# Neovim 設定

lazy.nvim を土台にしたフルスクラッチ構成。

## 構造

```
init.lua              leader とキャッシュだけ決めて、あとは require する
lua/core/
  options.lua         vim.opt。プラグインに依存しない挙動
  keymaps.lua         プラグインに依存しないキーマップ
  autocmds.lua        自動コマンド (診断フロート、整形、インデント差分など)
  lazy.lua            lazy.nvim のブートストラップと全体設定
lua/plugins/
  ui.lua              tokyonight / lualine / indent-blankline / colorizer
  editor.lua          which-key / autopairs / winresizer / toggleterm
  explorer.lua        nvim-tree
  telescope.lua       ファジーファインダ
  treesitter.lua      構文解析
  lsp.lua             LSP + mason
  cmp.lua             blink.cmp
  format.lua          conform.nvim
  git.lua             gitsigns
lazy-lock.json        プラグインのバージョン固定
```

`lua/plugins/` に `.lua` を足すだけで自動的に読み込まれる。一覧を書き足す必要はない。

### なぜ `lua/core/lazy.lua` なのか

config の `lua/` は runtimepath の先頭に来る。`lua/lazy.lua` を作ると
`require("lazy")` がプラグイン本体ではなくそのファイルを拾ってしまうため、
1 階層下げてある。

## 依存する外部コマンド

| コマンド | 用途 | 無いとどうなるか |
|---|---|---|
| `git` | lazy.nvim のプラグイン取得 | 何も入らない |
| `rg` (ripgrep) | Telescope のファイル列挙・grep | `<Leader>p` / `<Leader>g` が動かない |
| `gcc` | Treesitter パーサのビルド | ハイライトが素の正規表現に落ちる |
| `node` / `go` | mason が LSP サーバを入れるときに使う | 該当言語のサーバが入らない |

LSP サーバとフォーマッタは mason が `nvim-data/mason` 以下に入れる。
リポジトリには含まれないので、新しいマシンでは初回起動時に自動で揃う。

## キーマップ

leader は `Space`。`<Leader>` を押して待つと which-key が候補を出す。

### ウィンドウ・ファイル

| キー | 動作 |
|---|---|
| `<Leader>h` `j` `k` `l` | ウィンドウ移動 |
| `<Leader>s` / `<Leader>v` | 水平分割 / 垂直分割 |
| `<C-e>` | ウィンドウサイズ調整モード |
| `<Leader>w` / `<Leader>q` / `<Leader>wq` | 保存 / 閉じる / 保存して閉じる |
| `<S-h>` / `<S-l>` | 前 / 次のバッファ |
| `<Leader>tr` / `<Leader>tf` | ファイルツリー / ツリーで現在位置 |

### 検索 (Telescope)

| キー | 動作 |
|---|---|
| `<Leader>p` | ファイル検索 |
| `<Leader>g` | テキスト検索 (grep) |
| `<Leader>r` | 前回の検索を再開 |
| `<Leader>ff` `fg` `fw` `fo` `fh` `fk` `fd` `fq` | ファイル / grep / カーソル語 / 履歴 / ヘルプ / キーマップ / 診断 / Quickfix |
| `<Leader>bb` | バッファ一覧 |

### コード (LSP)

| キー | 動作 |
|---|---|
| `gd` `gr` `gi` `gy` `gD` | 定義 / 参照 / 実装 / 型定義 / 宣言 |
| `K` | ホバー |
| `<Leader>cr` / `<Leader>ca` | リネーム / コードアクション |
| `<Leader>cf` | 整形 |
| `<Leader>cs` / `<Leader>ci` | シンボル一覧 / インレイヒント切り替え |
| `<Leader>e` / `[d` / `]d` | 診断表示 / 前の診断 / 次の診断 |

### Git

| キー | 動作 |
|---|---|
| `[c` / `]c` | 前 / 次のハンク |
| `<Leader>Gp` `Gs` `Gr` `Gb` `Gd` `Gt` | プレビュー / ステージ / 戻す / blame / 差分 / blame 常時表示 |

### 編集

| キー | 動作 |
|---|---|
| `jk` (挿入モード) | ノーマルモードへ |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` (挿入モード) | カーソル移動 |
| `<C-n>` / `<C-p>` (補完中) | 候補を上下 |
| `<C-space>` | Treesitter で選択範囲を広げる |
| `J` / `K` (選択中) | 選択行を上下に移動 |
| `<C-/>` | コメント切り替え |
| `<Leader>tt` / `<Leader>th` | ターミナル (フロート / 下部) |

## 運用メモ

- 保存時に conform で自動整形する。他人のリポジトリで差分を出したくないときは
  `:FormatDisable`(全体) / `:FormatDisable!`(このバッファのみ)、戻すのは `:FormatEnable`。
- プラグイン更新は `:Lazy update`。**更新したら `lazy-lock.json` を必ずコミットする。**
- 起動時間が気になったら `:Lazy profile`。
- 環境が壊れたら `:checkhealth`。

## 既知の注意点

- **nvim-treesitter は `master` ブランチに固定している。** 上流は `main` ブランチで
  作り直しが進んでおり、設定 API が変わる。移行は自分のタイミングで行う。
- **tree-sitter CLI 0.25 以降との非互換を設定側で回避している。**
  master ブランチは `tree-sitter generate --no-bindings` をハードコードしているが、
  この引数は 0.25 で削除された。`lua/plugins/treesitter.lua` で生成引数を
  上書きすることで、`latex` のような grammar.js からの生成が必要なパーサを通している。
- Nerd Font を持たない端末で記号が豆腐になる場合は `init.lua` の
  `vim.g.have_nerd_font` を `false` にする。
