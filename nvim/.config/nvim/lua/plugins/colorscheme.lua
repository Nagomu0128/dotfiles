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
      bufferline = true,
      which_key = true,
      indent_blankline = { enabled = true },
      mason = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme('catppuccin-mocha')

    local function apply_overrides()
      -- NeoTreeDotfile は neo-tree.nvim 本体が #626262 (暗い灰色) にハードコードしており
      -- Catppuccin 側では上書きされないため、明示的に明るい色を指定する
      vim.api.nvim_set_hl(0, 'NeoTreeDotfile', { fg = '#edf0fa' })

      -- ホバーなどのフローティングウィンドウは、WezTerm の透過が薄い色だと
      -- デスクトップの背景と混ざって輪郭が分からなくなる。crust (最も暗い色) を敷いて
      -- 透過の影響を受けにくい安定した濃さの板にし、青系の枠線で境界をはっきりさせる
      vim.api.nvim_set_hl(0, 'NormalFloat', { fg = '#cdd6f4', bg = '#11111b' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#89b4fa', bg = '#11111b' })
    end
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = 'catppuccin-mocha',
      callback = apply_overrides,
    })
    apply_overrides()
  end,
}
