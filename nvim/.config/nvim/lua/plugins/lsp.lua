return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    opts = {
      -- Mason 上の名前 (lspconfig の server 名と異なる場合があるため明示)
      ensure_installed = {
        'ts_ls',      -- TypeScript / JavaScript
        'pyright',    -- Python
        'ruff',       -- Python linter/formatter (LSP経由)
        'lua_ls',     -- Lua
        'gopls',      -- Go
        'terraformls',-- Terraform / HCL
        'jsonls',     -- JSON
        'yamlls',     -- YAML
        'taplo',      -- TOML
        'bashls',     -- Shell script
        'marksman',   -- Markdown
      },
      -- インストール済みサーバーを自動で vim.lsp.enable() する。
      -- stylua は --lsp モードを持つが conform.nvim 経由で使うため除外
      automatic_enable = { exclude = { 'stylua' } },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Neovim 0.11+ の新API (vim.lsp.config/enable) を使用。
      -- nvim-lspconfig は各サーバーのデフォルト定義を提供するだけで、
      -- require('lspconfig')[name].setup{} は非推奨 (:help lspconfig-nvim-0.11)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- 診断アイコン
      vim.diagnostic.config({
        virtual_text = { prefix = '●' },
        severity_sort = true,
      })

      -- LSP アタッチ時のキーマップ
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
          end
          map('gd', vim.lsp.buf.definition, '定義へジャンプ')
          map('gr', vim.lsp.buf.references, '参照を検索')
          map('gI', vim.lsp.buf.implementation, '実装へジャンプ')
          map('K', vim.lsp.buf.hover, 'ホバー情報')
          map('<leader>rn', vim.lsp.buf.rename, 'リネーム')
          map('<leader>ca', vim.lsp.buf.code_action, 'コードアクション')
          map('<leader>D', vim.lsp.buf.type_definition, '型定義へジャンプ')
        end,
      })

      -- 全サーバー共通のデフォルト設定
      vim.lsp.config('*', { capabilities = capabilities })

      vim.lsp.config('gopls', {
        settings = { gopls = { gofumpt = true } },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- サーバーの有効化自体は mason-lspconfig の automatic_enable が行う
    end,
  },
}
