-- Git。差分の可視化とハンク単位の操作を行番号の横で完結させる。

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = "┃" },
      change       = { text = "┃" },
      delete       = { text = "▁" },
      topdelete    = { text = "▔" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local function map(mode, keys, fn, desc)
        vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = "Git: " .. desc })
      end

      -- ハンク移動。差分表示中は素の ]c / [c にフォールバックさせる。
      map("n", "]c", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gs.nav_hunk("next") end)
        return "<Ignore>"
      end, "次のハンクへ")
      map("n", "[c", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gs.nav_hunk("prev") end)
        return "<Ignore>"
      end, "前のハンクへ")

      map("n", "<Leader>Gp", gs.preview_hunk,   "ハンクをプレビュー")
      map("n", "<Leader>Gs", gs.stage_hunk,     "ハンクをステージ")
      map("n", "<Leader>Gr", gs.reset_hunk,     "ハンクを戻す")
      map("n", "<Leader>Gb", function() gs.blame_line({ full = true }) end, "行の blame")
      map("n", "<Leader>Gd", gs.diffthis,       "差分を開く")
      map("n", "<Leader>Gt", gs.toggle_current_line_blame, "行 blame の常時表示")
    end,
  },
}
