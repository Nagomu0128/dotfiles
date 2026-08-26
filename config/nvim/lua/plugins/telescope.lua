-- ファジーファインダ。ファイル検索・grep・LSP の各種一覧をここに集約する。

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  cmd = "Telescope",
  keys = {
    -- 手に馴染んでいる 3 つは 1 打で出す
    { "<Leader>p", "<cmd>Telescope find_files<cr>", desc = "ファイル検索" },
    { "<Leader>g", "<cmd>Telescope live_grep<cr>",  desc = "テキスト検索 (grep)" },
    { "<Leader>r", "<cmd>Telescope resume<cr>",     desc = "前回の検索を再開" },
    -- それ以外は <Leader>f 配下にまとめる
    { "<Leader>ff", "<cmd>Telescope find_files<cr>",  desc = "ファイル" },
    { "<Leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "grep" },
    { "<Leader>fw", "<cmd>Telescope grep_string<cr>", desc = "カーソル位置の語を検索" },
    { "<Leader>fo", "<cmd>Telescope oldfiles<cr>",    desc = "最近開いたファイル" },
    { "<Leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "ヘルプ" },
    { "<Leader>fk", "<cmd>Telescope keymaps<cr>",     desc = "キーマップ" },
    { "<Leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "診断一覧" },
    { "<Leader>fq", "<cmd>Telescope quickfix<cr>",    desc = "Quickfix" },
    { "<Leader>bb", "<cmd>Telescope buffers<cr>",     desc = "バッファ一覧" },
  },
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        prompt_prefix = vim.g.have_nerd_font and "   " or "> ",
        selection_caret = vim.g.have_nerd_font and " " or "> ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
        },
        -- live_grep / grep_string は ripgrep を呼ぶ。
        -- 隠しファイルは見たいが .git の中身は要らない。
        vimgrep_arguments = {
          "rg", "--color=never", "--no-heading", "--with-filename",
          "--line-number", "--column", "--smart-case", "--hidden", "--glob", "!**/.git/*",
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<Esc>"] = actions.close, -- 挿入モードから一発で閉じる
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- ripgrep をファイル列挙にも使う (fd を別途入れなくて済む)
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    }
  end,
}
