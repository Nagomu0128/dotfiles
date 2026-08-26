-- 自動コマンド。グループを切って clear = true にしておくと、
-- :source $MYVIMRC で再読み込みしても二重登録されない。

local augroup = function(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- ヤンクした範囲を一瞬光らせる。どこをコピーしたか目で追える。
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

-- カーソルを止めたら診断をフロートで出す。
-- virtual_text を切っている (core/options.lua) ぶんをこれで補う。
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = augroup("float_diagnostic"),
  callback = function()
    -- 補完メニューやフロートが既に開いているときに割り込まない
    if vim.fn.pumvisible() == 1 then
      return
    end
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(win).relative ~= "" then
        return
      end
    end
    vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
  end,
})

-- 前回閉じたときのカーソル位置に戻す
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_location"),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ヘルプや quickfix など「読むだけ」のバッファは q で閉じられるようにする
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = { "help", "qf", "man", "lspinfo", "checkhealth", "startuptime", "notify" },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true })
  end,
})

-- 言語ごとのインデント。core/options.lua の既定 (スペース 2) からの差分だけ書く。
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("indent_by_filetype"),
  pattern = { "go", "gomod", "make" },
  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("indent_python"),
  pattern = { "python" },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
  end,
})

-- 保存時に行末の空白を落とす。差分を汚さないため markdown は対象外。
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("trim_whitespace"),
  callback = function()
    if vim.bo.filetype == "markdown" then
      return
    end
    local view = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- 存在しないディレクトリに保存しようとしたら自動で掘る
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_mkdir"),
  callback = function(args)
    if args.match:match("^%w%w+://") then
      return
    end
    vim.fn.mkdir(vim.fn.fnamemodify(args.match, ":p:h"), "p")
  end,
})
