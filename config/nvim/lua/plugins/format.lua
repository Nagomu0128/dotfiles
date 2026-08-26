-- 整形。LSP の formatting ではなく conform に一本化して、
-- 「どのファイルをどのツールで整形するか」を 1 箇所で読めるようにする。

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<Leader>cf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      mode = { "n", "v" },
      desc = "整形",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- prettierd が無ければ prettier に落ちる
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      go = { "goimports", "gofmt" },
      python = { "ruff_fix", "ruff_format" },
      tex = { "latexindent" }, -- texlive に同梱されているものを使う
    },

    format_on_save = function(bufnr)
      -- :FormatDisable で一時的に切れるようにしておく。
      -- 他人のリポジトリを触るときに整形差分を出さないため。
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,
  },
  init = function()
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true -- このバッファだけ
      else
        vim.g.disable_autoformat = true
      end
    end, { desc = "保存時整形を止める", bang = true })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "保存時整形を再開する" })
  end,
}
