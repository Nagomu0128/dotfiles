local map = vim.keymap.set

-- 検索ハイライト解除
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- 保存・終了
map('n', '<leader>w', '<cmd>write<CR>', { desc = '保存' })
map('n', '<leader>q', '<cmd>quit<CR>', { desc = '終了' })

-- バッファ移動
map('n', '<S-l>', '<cmd>bnext<CR>', { desc = '次のバッファ' })
map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = '前のバッファ' })
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'バッファを閉じる' })

-- 分割ウィンドウ作成 (ペイン移動/リサイズは smart-splits.nvim が Ctrl+hjkl / Opt+hjkl を担当)
map('n', '<leader>sv', '<C-w>v', { desc = '垂直分割' })
map('n', '<leader>sh', '<C-w>s', { desc = '水平分割' })

-- 選択範囲を保ったままインデント
map('v', '<', '<gv')
map('v', '>', '>gv')

-- 選択行の移動
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- 診断
map('n', '[d', vim.diagnostic.goto_prev, { desc = '前の診断' })
map('n', ']d', vim.diagnostic.goto_next, { desc = '次の診断' })
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = '診断を表示' })
