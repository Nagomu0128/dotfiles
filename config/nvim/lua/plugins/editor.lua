-- 編集操作を助ける小物。

return {
  -- キーマップのチートシート。<Leader> を押して待つと候補が出る ------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        -- グループ名を付けておくと <Leader> 待ち受け画面が読める
        { "<Leader>b", group = "バッファ" },
        { "<Leader>f", group = "検索 (Telescope)" },
        { "<Leader>G", group = "Git" },
        { "<Leader>t", group = "ターミナル" },
        { "<Leader>c", group = "コード (LSP)" },
      },
    },
  },

  -- 括弧・引用符の自動補完 --------------------------------------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- Treesitter を見て、文字列やコメント内では閉じない
    },
  },

  -- 分割ウィンドウのサイズ調整を hjkl でやる --------------------------------
  {
    "simeji/winresizer",
    cmd = "WinResizerStartResize",
    keys = {
      { "<C-e>", "<cmd>WinResizerStartResize<cr>", desc = "ウィンドウサイズ調整" },
    },
  },

  -- ターミナル --------------------------------------------------------------
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<Leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "ターミナル (フロート)" },
      { "<Leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "ターミナル (下部)" },
    },
    opts = {
      size = 15,
      float_opts = { border = "rounded" },
      -- ターミナル内では <Esc><Esc> でノーマルモードに戻る (core/keymaps.lua と揃える)
      on_open = function(term)
        vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { buffer = term.bufnr })
      end,
    },
  },
}
