return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    options = {
      mode = 'buffers',
      diagnostics = 'nvim_lsp',
      always_show_bufferline = true,
      show_close_icon = false,
      show_buffer_close_icons = true,
      -- Neo-tree のサイドバー分だけタブラインをずらす
      offsets = {
        {
          filetype = 'neo-tree',
          text = '',
          highlight = 'Directory',
          separator = true,
        },
      },
    },
  },
}
