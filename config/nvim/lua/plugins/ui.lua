-- 見た目まわり。配色・ステータスライン・インデント補助。

return {
  -- 配色 --------------------------------------------------------------------
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- 他プラグインより先に読み、起動時の色のちらつきを防ぐ
    config = function()
      require("tokyonight").setup({
        style = "storm",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        on_highlights = function(hl, c)
          -- 透過を効かせたままだと Telescope とフロート系が背景に溶けて
          -- 境界が読めなくなるので、そこだけ暗い背景を敷き直す
          local dark = { bg = c.bg_dark, fg = c.fg_dark }
          hl.TelescopeNormal = dark
          hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptNormal = { bg = c.bg_dark }
          hl.TelescopePromptBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptTitle = dark
          hl.TelescopeResultsTitle = dark
          hl.TelescopePreviewTitle = dark
          hl.NormalFloat = dark
          hl.FloatBorder = { bg = c.bg_dark, fg = c.blue }
          hl.WhichKeyNormal = { bg = c.bg_dark }
          hl.LazyNormal = dark
          hl.MasonNormal = dark
        end,
      })
      vim.cmd.colorscheme("tokyonight-storm")
    end,
  },

  -- ステータスライン --------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return {
        options = {
          theme = "tokyonight",
          globalstatus = true, -- 分割しても下部に 1 本だけ出す
          icons_enabled = vim.g.have_nerd_font,
          component_separators = "",
          section_separators = vim.g.have_nerd_font and { left = "", right = "" } or "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", path = 1 } }, -- カレントからの相対パス
          lualine_x = {
            { "diagnostics", sources = { "nvim_lsp" } },
            -- どの LSP が今のバッファに付いているか一目で分かるようにする
            {
              function()
                local names = {}
                for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                  table.insert(names, client.name)
                end
                return table.concat(names, " ")
              end,
              icon = vim.g.have_nerd_font and "" or "LSP",
            },
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },

  -- インデントガイド --------------------------------------------------------
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = true, show_start = false, show_end = false },
      exclude = { filetypes = { "help", "lazy", "mason", "NvimTree", "dashboard" } },
    },
  },

  -- カラーコードをその色で表示する (#RRGGBB など) ----------------------------
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
