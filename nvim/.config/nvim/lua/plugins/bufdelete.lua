-- :bdelete は最後のバッファ/ウィンドウの場合に Neovim ごと終了してしまうことがあるため、
-- ウィンドウレイアウトを保ったままバッファだけを削除できる :Bdelete に置き換える
return {
  'famiu/bufdelete.nvim',
  cmd = { 'Bdelete', 'Bwipeout' },
}
