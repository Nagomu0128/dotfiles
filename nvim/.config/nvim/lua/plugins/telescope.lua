return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    'nvim-telescope/telescope-ui-select.nvim',
  },
  cmd = 'Telescope',
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'ファイル検索' },
    { '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = '全文検索(grep)' },
    { '<leader>fb', '<cmd>Telescope buffers<CR>', desc = 'バッファ一覧' },
    { '<leader>fh', '<cmd>Telescope help_tags<CR>', desc = 'ヘルプ検索' },
    { '<leader>fr', '<cmd>Telescope oldfiles<CR>', desc = '最近開いたファイル' },
    { '<leader>fd', '<cmd>Telescope diagnostics<CR>', desc = '診断一覧' },
    { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<CR>', desc = 'バッファ内検索' },
  },
  config = function()
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        -- nvim-treesitter がリライトされ nvim-treesitter.parsers.ft_to_lang が
        -- 廃止されたため、telescope の treesitter プレビューが未対応でクラッシュする。
        -- 通常の構文ハイライト(regex)にフォールバックさせる。
        preview = { treesitter = false },
      },
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
      },
    })
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
  end,
}
