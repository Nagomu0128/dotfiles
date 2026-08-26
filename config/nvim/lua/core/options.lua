-- エディタの素の挙動。プラグインに依存しない設定だけをここに置く。

local opt = vim.opt

-- 表示 ----------------------------------------------------------------------
opt.number = true
opt.relativenumber = true      -- 相対行番号。5j / 12k のような移動がしやすい
opt.cursorline = true
opt.signcolumn = "yes"         -- 診断アイコンの出入りで画面が横揺れしないよう常時確保
opt.wrap = false
opt.scrolloff = 8              -- カーソル上下に常に 8 行残す
opt.sidescrolloff = 8
opt.termguicolors = true
opt.showmode = false           -- モード表示は lualine が出すので素のものは消す
opt.splitright = true          -- 縦分割は右に開く
opt.splitbelow = true          -- 横分割は下に開く
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.winblend = 10              -- フロートウィンドウを少し透過させる
opt.pumheight = 12             -- 補完候補が画面を占有しすぎないように

-- インデント ----------------------------------------------------------------
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
-- 言語ごとの差分 (Go はタブ、Python は 4) は core/autocmds.lua で上書きする

-- 検索 ----------------------------------------------------------------------
opt.ignorecase = true
opt.smartcase = true           -- 大文字を含む検索語のときだけ大小を区別する
opt.hlsearch = true
opt.incsearch = true

-- ファイル・履歴 ------------------------------------------------------------
opt.swapfile = false
opt.backup = false
opt.undofile = true            -- nvim を閉じても undo 履歴を保持する
opt.updatetime = 250           -- CursorHold の発火間隔。診断フロートの体感速度に効く
opt.timeoutlen = 400           -- <Leader>w と <Leader>wq を打ち分けられる程度の待ち時間

-- その他 --------------------------------------------------------------------
opt.encoding = "utf-8"
opt.fileencodings = { "utf-8", "cp932", "euc-jp" }  -- Windows で拾う既存ファイル向け
opt.clipboard = "unnamedplus"  -- ヤンクを OS クリップボードと共有する
opt.mouse = "a"
opt.confirm = true             -- 未保存で閉じようとしたら破棄せず確認する
opt.completeopt = { "menu", "menuone", "noselect" }

-- 診断の見た目 --------------------------------------------------------------
local signs = vim.g.have_nerd_font
    and { ERROR = " ", WARN = " ", INFO = " ", HINT = " " }
    or  { ERROR = "E ", WARN = "W ", INFO = "I ", HINT = "H " }

vim.diagnostic.config({
  virtual_text = false,        -- 行末に出さず、CursorHold のフロートで読む (autocmds.lua)
  severity_sort = true,
  float = { border = "rounded", source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.ERROR,
      [vim.diagnostic.severity.WARN]  = signs.WARN,
      [vim.diagnostic.severity.INFO]  = signs.INFO,
      [vim.diagnostic.severity.HINT]  = signs.HINT,
    },
  },
})
