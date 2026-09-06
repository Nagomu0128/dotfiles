return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    on_attach = function(bufnr)
      local gs = require('gitsigns')
      local map = function(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end
      map('n', ']h', gs.next_hunk, '次の変更箇所')
      map('n', '[h', gs.prev_hunk, '前の変更箇所')
      map('n', '<leader>hs', gs.stage_hunk, '変更をステージ')
      map('n', '<leader>hr', gs.reset_hunk, '変更を取り消し')
      map('n', '<leader>hp', gs.preview_hunk, '変更をプレビュー')
    end,
  },
}
