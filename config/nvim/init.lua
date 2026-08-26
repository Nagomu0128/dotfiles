-- Neovim エントリポイント
--
-- ここでは「lazy.nvim を読む前に決めておかないと手遅れになるもの」だけを扱い、
-- 実際の設定は lua/core と lua/plugins に分ける。

-- Lua モジュールのバイトコードキャッシュ。Windows はファイル I/O が遅いので効果が大きい。
vim.loader.enable()

-- leader は「キーマップが定義される前」に決まっている必要がある。
-- lazy.nvim はプラグイン仕様の keys を読み込み時に登録するため、必ずここで設定する。
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- アイコン表示の可否。WezTerm は Nerd Font シンボルを内蔵フォールバックとして持つため
-- 既定で有効にしている。Nerd Font を持たない端末で豆腐になる場合は false にする。
vim.g.have_nerd_font = true

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lazy")
