return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = { 'williamboman/mason.nvim' },
  opts = {
    -- lspconfig 経由でインストールされない、フォーマッタ/リンタ単体ツール
    ensure_installed = {
      'stylua',
      'prettier',
      'shfmt',
    },
  },
}
