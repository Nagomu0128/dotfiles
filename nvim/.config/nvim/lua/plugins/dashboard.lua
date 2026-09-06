-- スタート画面。Snacks.dashboard.pick() は telescope.nvim を自動検出して使う。
-- https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      preset = {
        header = [[
 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
        keys = {
          { icon = ' ', key = 'f', desc = 'ファイルを検索', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'r', desc = '最近のファイル', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = ' ', key = 'g', desc = '全文検索(grep)', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'n', desc = '新規ファイル', action = ':enew' },
          { icon = ' ', key = 'c', desc = '設定を開く', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = '󰒲 ', key = 'L', desc = 'プラグイン管理(Lazy)', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = '終了', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { icon = ' ', title = '最近のファイル', section = 'recent_files', indent = 2, padding = 1 },
        { icon = ' ', title = 'プロジェクト', section = 'projects', indent = 2, padding = 1 },
        { section = 'startup' },
      },
    },
  },
}
