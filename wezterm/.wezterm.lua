local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- フォント
config.font = wezterm.font("Cascadia Code")
config.font_size = 12.0

-- 配色
config.color_scheme = "Tokyo Night"

-- ウィンドウ
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}
config.window_background_opacity = 0.92

-- タブバー
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- デフォルトのシェル（PowerShell 7）
config.default_prog = { "pwsh.exe" }
config.default_cwd = "C:/project"

-- ランチャーメニュー（Alt+l で開く）
config.launch_menu = {
  { label = "Ubuntu", args = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" } },
}

-- キーバインド
config.keys = {
  { key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
}

return config
