-- ファイルツリー。Telescope で辿れない「構造の把握」用途に絞って使う。

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  keys = {
    { "<Leader>tr", "<cmd>NvimTreeToggle<cr>", desc = "ファイルツリー" },
    { "<Leader>tf", "<cmd>NvimTreeFindFile<cr>", desc = "ツリーで現在のファイルを表示" },
  },
  opts = {
    hijack_netrw = true,
    view = { width = 34 },
    renderer = {
      group_empty = true, -- 空の中間ディレクトリを 1 行にまとめる
      icons = { show = { file = vim.g.have_nerd_font, folder = vim.g.have_nerd_font } },
    },
    filters = { dotfiles = false, custom = { "^.git$" } },
    actions = { open_file = { quit_on_open = false } },
    git = { enable = true, ignore = false },
  },
}
