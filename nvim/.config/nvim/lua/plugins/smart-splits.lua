-- WezTerm 側 (~/dotfiles/wezterm/.config/wezterm/keybinds.lua) の
-- smart_splits.apply_to_config と対になる設定。
-- 移動: Ctrl+hjkl / リサイズ: Opt(Alt)+hjkl をペイン・分割ウィンドウ間で共通化する。
-- https://github.com/mrjones2014/smart-splits.nvim
return {
  'mrjones2014/smart-splits.nvim',
  lazy = false, -- WezTerm 連携を使うため遅延ロードしない
  opts = {
    multiplexer_integration = 'wezterm',
  },
  keys = {
    { '<C-h>', function() require('smart-splits').move_cursor_left() end, desc = '左のペインへ移動' },
    { '<C-j>', function() require('smart-splits').move_cursor_down() end, desc = '下のペインへ移動' },
    { '<C-k>', function() require('smart-splits').move_cursor_up() end, desc = '上のペインへ移動' },
    { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = '右のペインへ移動' },
    { '<A-h>', function() require('smart-splits').resize_left() end, desc = 'ペインを左にリサイズ' },
    { '<A-j>', function() require('smart-splits').resize_down() end, desc = 'ペインを下にリサイズ' },
    { '<A-k>', function() require('smart-splits').resize_up() end, desc = 'ペインを上にリサイズ' },
    { '<A-l>', function() require('smart-splits').resize_right() end, desc = 'ペインを右にリサイズ' },
    { '<leader><leader>h', function() require('smart-splits').swap_buf_left() end, desc = 'バッファを左と入れ替え' },
    { '<leader><leader>j', function() require('smart-splits').swap_buf_down() end, desc = 'バッファを下と入れ替え' },
    { '<leader><leader>k', function() require('smart-splits').swap_buf_up() end, desc = 'バッファを上と入れ替え' },
    { '<leader><leader>l', function() require('smart-splits').swap_buf_right() end, desc = 'バッファを右と入れ替え' },
  },
}
