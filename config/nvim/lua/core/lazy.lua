-- lazy.nvim のブートストラップと全体設定。
--
-- 置き場所について: このファイルは lua/lazy.lua ではなく lua/core/lazy.lua に置く。
-- config の lua/ は runtimepath の先頭に来るため、lua/lazy.lua を作ると
-- require("lazy") がプラグイン本体ではなくこのファイルを拾ってしまう。

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "lazy.nvim の取得に失敗しました:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- lua/plugins/ 配下の *.lua を全部プラグイン仕様として読み込む。
  -- ファイルを足すだけで有効になるので、ここに一覧を書き足す必要はない。
  spec = { { import = "plugins" } },

  defaults = {
    -- 明示的に lazy = false / event / keys を書いた仕様だけを尊重する。
    -- 個々の仕様側で読み込みタイミングを管理する方針。
    lazy = false,
    version = false, -- 原則 git の最新を追い、固定は lazy-lock.json で行う
  },

  install = { colorscheme = { "tokyonight" } },

  -- 起動時に更新チェックへ行かない。ネットワーク待ちで起動が伸びるのを避ける。
  -- 更新は :Lazy update を明示的に叩いたときだけ。
  checker = { enabled = false },
  change_detection = { enabled = true, notify = false },

  performance = {
    rtp = {
      -- 使っていない標準プラグインを runtimepath から外して起動を軽くする
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "netrwPlugin",
      },
    },
  },

  ui = { border = "rounded" },
})

vim.keymap.set("n", "<Leader>L", "<cmd>Lazy<cr>", { desc = "Lazy を開く" })
