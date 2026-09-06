-- nvim-treesitter (リライト後の新API)。この版は遅延ロードに非対応のため lazy=false。
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ensure_installed = {
      'lua', 'vim', 'vimdoc', 'query',
      'typescript', 'javascript', 'tsx',
      'python',
      'go', 'gomod', 'gowork', 'gosum',
      'terraform', 'hcl',
      'json', 'yaml', 'toml',
      'markdown', 'markdown_inline',
      'bash', 'dockerfile', 'gitignore',
    }

    require('nvim-treesitter').setup()
    require('nvim-treesitter').install(ensure_installed)

    -- jsonc には専用パーサーがないため json のパーサーを流用する
    vim.treesitter.language.register('json', 'jsonc')

    -- ハイライトと(実験的)インデントを有効化
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)
        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
