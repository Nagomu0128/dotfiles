local opt = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 表示
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.termguicolors = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- インデント
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- 検索
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- 編集体験
opt.clipboard = 'unnamedplus'
opt.undofile = true
opt.swapfile = false
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = { 'menuone', 'noselect' }
opt.mouse = 'a'

-- WezTerm 側のトゥルーカラー/ぼかし背景と噛み合わせる
opt.pumblend = 10
opt.winblend = 0
