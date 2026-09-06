local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- コピー(yank)時にハイライトする
autocmd('TextYankPost', {
  group = augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- 前回の編集位置にカーソルを復元
autocmd('BufReadPost', {
  group = augroup('restore-cursor', { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lines = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lines then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 保存時に末尾の余分な空白を削除
autocmd('BufWritePre', {
  group = augroup('trim-trailing-whitespace', { clear = true }),
  pattern = '*',
  command = [[%s/\s\+$//e]],
})
