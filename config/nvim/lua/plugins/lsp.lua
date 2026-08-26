-- LSP。Neovim 0.11 以降の組み込み API (vim.lsp.config / vim.lsp.enable) を使い、
-- サーバ本体の導入は mason に任せる。

return {
  -- Neovim 設定を書くときだけ lua_ls に nvim の型情報を食わせる ------------
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- 入れておきたい言語サーバ。mason が未導入なら自動で取りに行く。
      local servers = {
        "lua_ls",     -- Lua
        "ts_ls",      -- TypeScript / JavaScript
        "gopls",      -- Go
        "pyright",    -- Python (npm 配布。この環境の python スタブ問題を踏まない)
        "ruff",       -- Python の lint / format
        "texlab",     -- LaTeX
        "jsonls",     -- package.json / tsconfig.json
      }

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = true, -- 導入済みサーバに対して vim.lsp.enable を呼ぶ
      })

      -- LSP ではないツール (フォーマッタ) もここで揃える
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",     -- Lua
          "prettierd",  -- TS/JS/JSON/YAML/Markdown
          "goimports",  -- Go
        },
        run_on_start = true,
        auto_update = false,
      })

      -- 全サーバ共通の設定 ---------------------------------------------------
      vim.lsp.config("*", {
        root_markers = { ".git" },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            -- vim グローバルを未定義扱いさせない
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            format = { enable = false }, -- 整形は conform + stylua に任せる
          },
        },
      })

      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
          },
        },
      })

      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              -- lint は ruff が見るので pyright は型に集中させる
              typeCheckingMode = "basic",
              diagnosticSeverityOverrides = { reportUnusedImport = "none" },
            },
          },
        },
      })

      vim.lsp.config("texlab", {
        settings = {
          texlab = {
            build = {
              executable = "latexmk",
              args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              onSave = false,
            },
          },
        },
      })

      -- バッファに LSP が付いたときだけキーマップを張る -----------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
        callback = function(args)
          local function map(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = args.buf, desc = "LSP: " .. desc })
          end

          -- 定義・参照ジャンプは Telescope 経由にして一覧から選べるようにする
          map("gd", "<cmd>Telescope lsp_definitions<cr>", "定義へ")
          map("gr", "<cmd>Telescope lsp_references<cr>", "参照一覧")
          map("gi", "<cmd>Telescope lsp_implementations<cr>", "実装へ")
          map("gy", "<cmd>Telescope lsp_type_definitions<cr>", "型定義へ")
          map("gD", vim.lsp.buf.declaration, "宣言へ")
          map("K", vim.lsp.buf.hover, "ホバー")
          map("<Leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", "シンボル一覧")

          map("<Leader>cr", vim.lsp.buf.rename, "リネーム")
          map("<Leader>ca", vim.lsp.buf.code_action, "コードアクション")
          vim.keymap.set("v", "<Leader>ca", vim.lsp.buf.code_action,
            { buffer = args.buf, desc = "LSP: コードアクション" })

          -- インレイヒント (対応サーバのみ)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            map("<Leader>ci", function()
              local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
              vim.lsp.inlay_hint.enable(not enabled, { bufnr = args.buf })
            end, "インレイヒント切り替え")
          end
        end,
      })
    end,
  },
}
