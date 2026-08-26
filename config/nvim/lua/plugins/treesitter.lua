-- 構文解析。ハイライト・インデント・テキストオブジェクトの土台になる。
--
-- branch は master を明示している。nvim-treesitter は main ブランチで作り直しが
-- 進んでおり、既定ブランチが切り替わると設定 API ごと変わるため、
-- 移行を自分のタイミングで行えるように固定しておく。

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdate", "TSInstall", "TSInstallSync", "TSInstallInfo", "TSModuleInfo" },
  config = function()
    -- tree-sitter CLI 0.25 以降で `--no-bindings` が削除されたが、
    -- nvim-treesitter (master) はこの引数をハードコードしている。
    -- そのため grammar.js からの生成が必要なパーサ (latex など) が
    -- "unexpected argument '--no-bindings'" で失敗する。
    -- 生成引数を先に埋めておくことで、この分岐を迂回する。
    require("nvim-treesitter.install").ts_generate_args = {
      "generate", "--abi", tostring(vim.treesitter.language_version),
    }

    require("nvim-treesitter.configs").setup({
      -- パーサは C コンパイラでビルドされる。Windows では mingw64 の gcc を使う。
      ensure_installed = {
        "lua", "luadoc", "vim", "vimdoc", "query",
        "typescript", "tsx", "javascript", "json", "jsonc",
        "go", "gomod", "gosum",
        "python",
        "latex", "bibtex",
        "html", "css", "yaml", "toml", "markdown", "markdown_inline",
        "bash", "diff", "gitcommit", "gitignore",
      },
      auto_install = false, -- 開いた瞬間に勝手にビルドが走ると重いので手動 (:TSInstall)
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          node_decremental = "<BS>",
          scope_incremental = false,
        },
      },
    })
  end,
}
