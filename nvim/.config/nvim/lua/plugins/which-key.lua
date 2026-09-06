return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    spec = {
      { '<leader>f', group = '検索(Telescope)' },
      { '<leader>h', group = 'Git hunk' },
      { '<leader>g', group = 'Git (lazygit)' },
      { '<leader>b', group = 'バッファ' },
      { '<leader>s', group = '分割' },
      { '<leader>c', group = 'コード' },
    },
  },
}
