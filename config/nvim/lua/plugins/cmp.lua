-- 補完。blink.cmp は Rust 製のマッチャを持つが、
-- バイナリを取得できない環境では Lua 実装に自動で落ちる設定にしてある。

return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "1.*", -- リリースタグを使うとビルド済みバイナリが降ってくる
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    keymap = {
      preset = "default",       -- <C-space> で開く / <C-e> で閉じる
      ["<C-y>"] = { "select_and_accept" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      -- 挿入モードの <C-j>/<C-k> はカーソル移動に使っているので
      -- 候補移動は <C-n>/<C-p> に寄せる
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
    },

    appearance = { nerd_font_variant = "mono" },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      menu = { border = "rounded" },
      -- 勝手に確定させない。選ぶのは常に明示操作。
      list = { selection = { preselect = false, auto_insert = false } },
    },

    signature = { enabled = true, window = { border = "rounded" } },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        -- Neovim 設定を書いているときは lazydev の候補を優先する
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },

    fuzzy = {
      -- Rust バイナリを取れなければ警告を出して Lua 実装で動き続ける。
      -- Windows で「補完が丸ごと死ぬ」事故を避けるため。
      implementation = "prefer_rust_with_warning",
    },
  },
  opts_extend = { "sources.default" },
}
