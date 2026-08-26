# dotfiles

Nagomu0128 の dotfiles。Windows 11 をメイン環境として運用している。

## 構成

```
dotfiles/
├── config/
│   └── nvim/        Neovim 設定 (lazy.nvim, フルスクラッチ)
└── install.ps1      Windows 用セットアップ (リンク作成 + 依存ツール導入)
```

## セットアップ (Windows)

```powershell
git clone https://github.com/Nagomu0128/dotfiles.git "$env:USERPROFILE\dotfiles"
& "$env:USERPROFILE\dotfiles\install.ps1"
```

`install.ps1` は `%LOCALAPPDATA%\nvim` から `dotfiles\config\nvim` へジャンクションを張る。
ジャンクションは管理者権限も Developer Mode も不要。

## 運用

設定は `dotfiles/config/nvim/` を直接編集する。ジャンクション経由で Neovim に即反映されるので、
そのまま `git add` / `git commit` すればよい。

`:Lazy update` でプラグインを更新したら `lazy-lock.json` の差分を必ずコミットする。
これがプラグインのバージョンロックの実体で、他マシンでの再現性を担保している。
