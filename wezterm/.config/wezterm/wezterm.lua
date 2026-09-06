local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 保存すると即座に反映される
config.automatically_reload_config = true

----------------------------------------------------
-- 配色 (Catppuccin Mocha)
----------------------------------------------------
config.color_scheme = "Catppuccin Mocha"

-- フォント（Nerd Font を指定しないとタブの装飾が豆腐になる）
config.font = wezterm.font("HackGen35 Console NF")
config.font_size = 13.0
config.use_ime = true  -- 日本語入力

-- 透過とぼかし
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

----------------------------------------------------
-- タブ・ウィンドウ
----------------------------------------------------
config.window_decorations = "RESIZE"          -- タイトルバーを消す
config.hide_tab_bar_if_only_one_tab = true    -- タブ1つなら非表示
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.window_padding = { left = 12, right = 12, top = 8, bottom = 8 }

-- タブバー自体を透過させる
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}
config.colors = { tab_bar = { inactive_tab_edge = "none" } }

-- タブを台形に整形し、アクティブタブを Catppuccin Mocha のアクセントカラーで色分けする
local LEFT_EDGE = wezterm.nerdfonts.ple_lower_right_triangle
local RIGHT_EDGE = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
  local bg = tab.is_active and "#cba6f7" or "#45475a" -- mauve / surface1
  local fg = tab.is_active and "#1e1e2e" or "#a6adc8" -- base / subtext0
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
  return {
    { Background = { Color = "none" } },
    { Foreground = { Color = bg } },
    { Text = LEFT_EDGE },
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = title },
    { Background = { Color = "none" } },
    { Foreground = { Color = bg } },
    { Text = RIGHT_EDGE },
  }
end)

----------------------------------------------------
-- キーバインド
----------------------------------------------------
config.disable_default_key_bindings = true
require("keybinds").apply_to_config(config)

return config