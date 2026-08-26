-- プラグインに依存しないキーマップ。
-- Telescope や LSP など、プラグイン由来のものは各 lua/plugins/*.lua 側に置く
-- (そうしないと lazy-load のトリガーとして機能しないため)。

local map = vim.keymap.set

-- ウィンドウ ----------------------------------------------------------------
-- <C-w>h ではなく <Leader>h 系で移動する
map("n", "<Leader>h", "<C-w>h", { desc = "左のウィンドウへ" })
map("n", "<Leader>j", "<C-w>j", { desc = "下のウィンドウへ" })
map("n", "<Leader>k", "<C-w>k", { desc = "上のウィンドウへ" })
map("n", "<Leader>l", "<C-w>l", { desc = "右のウィンドウへ" })
map("n", "<Leader>s", "<cmd>split<cr>",  { desc = "水平分割" })
map("n", "<Leader>v", "<cmd>vsplit<cr>", { desc = "垂直分割" })

-- 保存・終了 ----------------------------------------------------------------
map("n", "<Leader>w",  "<cmd>write<cr>",      { desc = "保存" })
map("n", "<Leader>q",  "<cmd>quit<cr>",       { desc = "閉じる" })
map("n", "<Leader>wq", "<cmd>write | quit<cr>", { desc = "保存して閉じる" })

-- バッファ ------------------------------------------------------------------
map("n", "<S-l>", "<cmd>bnext<cr>",     { desc = "次のバッファ" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "前のバッファ" })
map("n", "<Leader>bd", "<cmd>bdelete<cr>", { desc = "バッファを閉じる" })

-- 挿入モードの移動 ----------------------------------------------------------
map("i", "jk", "<Esc>", { desc = "ノーマルモードへ" })
map("i", "<C-h>", "<Left>",  { desc = "左" })
map("i", "<C-j>", "<Down>",  { desc = "下" })
map("i", "<C-k>", "<Up>",    { desc = "上" })
map("i", "<C-l>", "<Right>", { desc = "右" })

-- 編集補助 ------------------------------------------------------------------
-- 選択範囲を行ごと上下に動かし、移動先のインデントに合わせ直す
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "選択行を下へ", silent = true })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "選択行を上へ", silent = true })
-- インデント後も選択を維持して連打できるようにする
map("v", "<", "<gv", { desc = "インデントを減らす" })
map("v", ">", ">gv", { desc = "インデントを増やす" })
-- ペーストで消えたレジスタに上書きされないようにする
map("v", "p", '"_dP', { desc = "貼り付け (レジスタを汚さない)" })

-- コメント (Ctrl+/ が端末上で <C-_> として届く)
map("n", "<C-_>", "gcc", { remap = true, desc = "行コメント" })
map("v", "<C-_>", "gc",  { remap = true, desc = "コメント切り替え" })
map("n", "<C-/>", "gcc", { remap = true, desc = "行コメント" })
map("v", "<C-/>", "gc",  { remap = true, desc = "コメント切り替え" })

-- 検索・診断 ----------------------------------------------------------------
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "検索ハイライト解除" })
map("n", "<Leader>e", vim.diagnostic.open_float, { desc = "診断を表示" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "前の診断へ" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1,  float = true }) end, { desc = "次の診断へ" })

-- ターミナル ----------------------------------------------------------------
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "ターミナルを抜ける" })

-- デバッグ ------------------------------------------------------------------
map("n", "<Leader>:", "<cmd>Inspect<cr>", { desc = "カーソル位置のハイライトを調べる" })
