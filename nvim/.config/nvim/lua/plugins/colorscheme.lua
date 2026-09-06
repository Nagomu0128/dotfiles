return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    flavour = 'mocha',
    transparent_background = true, -- WezTerm 側の透過・ぼかしを活かす
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      telescope = { enabled = true },
      native_lsp = { enabled = true },
      neotree = true,
      which_key = true,
      indent_blankline = { enabled = true },
      mason = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme('catppuccin-mocha')

    -- NeoTreeDotfile は neo-tree.nvim 本体が #626262 (暗い灰色) にハードコードしており
    -- Catppuccin 側では上書きされないため、明示的に明るい色を指定する
    local function brighten_neotree_dotfile()
      vim.api.nvim_set_hl(0, 'NeoTreeDotfile', { fg = '#edf0fa' })
    end
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = 'catppuccin-mocha',
      callback = brighten_neotree_dotfile,
    })
    brighten_neotree_dotfile()
  end,
}
