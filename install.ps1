<#
.SYNOPSIS
  Windows 用 dotfiles セットアップ。

.DESCRIPTION
  設定ファイルの実体は常に dotfiles リポジトリ側に置き、
  各ツールが見に行く既定パスからはジャンクションで参照させる。

  ジャンクション (mklink /J) を使うのは、シンボリックリンクと違って
  管理者権限も Developer Mode も要求しないため。

.EXAMPLE
  .\install.ps1
  .\install.ps1 -SkipTools    # リンクだけ張り、外部ツールの導入はしない
#>
[CmdletBinding()]
param(
  [switch]$SkipTools
)

$ErrorActionPreference = 'Stop'
$dotfiles = $PSScriptRoot

function New-Junction {
  param([string]$Link, [string]$Target)

  if (-not (Test-Path $Target)) {
    Write-Warning "リンク先が存在しません: $Target"
    return
  }

  if (Test-Path $Link) {
    $item = Get-Item $Link -Force
    $isReparse = $item.Attributes -band [IO.FileAttributes]::ReparsePoint
    if ($isReparse) {
      Write-Host "既にリンク済み: $Link" -ForegroundColor DarkGray
      return
    }
    # 実体が居座っている場合は消さずに退避する
    $backup = "$Link.bak-$(Get-Date -Format 'yyyyMMddHHmmss')"
    Move-Item $Link $backup
    Write-Host "既存の実体を退避しました: $backup" -ForegroundColor Yellow
  }

  New-Item -ItemType Directory -Force -Path (Split-Path $Link -Parent) | Out-Null
  cmd /c mklink /J "$Link" "$Target" | Out-Null
  Write-Host "リンク作成: $Link -> $Target" -ForegroundColor Green
}

# --- リンク -----------------------------------------------------------------
New-Junction -Link "$env:LOCALAPPDATA\nvim" -Target "$dotfiles\config\nvim"

# --- 外部ツール -------------------------------------------------------------
# Neovim 本体と、設定が前提にしているコマンドを揃える。
# LSP サーバとフォーマッタは mason が nvim 内で管理するのでここには含めない。
if (-not $SkipTools) {
  $packages = @(
    @{ Id = 'Neovim.Neovim';        Cmd = 'nvim';  Why = 'エディタ本体' },
    @{ Id = 'BurntSushi.ripgrep.MSVC'; Cmd = 'rg'; Why = 'Telescope のファイル列挙と grep' },
    @{ Id = 'Git.Git';              Cmd = 'git';   Why = 'lazy.nvim のプラグイン取得' }
  )

  foreach ($p in $packages) {
    if (Get-Command $p.Cmd -ErrorAction SilentlyContinue) {
      Write-Host "導入済み: $($p.Cmd)" -ForegroundColor DarkGray
      continue
    }
    Write-Host "導入します: $($p.Id) ($($p.Why))" -ForegroundColor Cyan
    winget install --id $p.Id --scope user --silent `
      --accept-source-agreements --accept-package-agreements
  }

  # Treesitter のパーサは C コンパイラでビルドされる。
  if (-not (Get-Command gcc -ErrorAction SilentlyContinue)) {
    Write-Warning 'gcc が見つかりません。Treesitter のパーサをビルドできません。'
    Write-Warning '  winget install --id MSYS2.MSYS2   などで mingw-w64 の gcc を用意してください。'
  }
}

Write-Host ''
Write-Host '完了しました。nvim を起動すると lazy.nvim がプラグインを取得します。' -ForegroundColor Green
Write-Host 'LSP サーバとフォーマッタは :Mason で状態を確認できます。' -ForegroundColor Green
