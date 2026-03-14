local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- フォント
config.font = wezterm.font("Cascadia Code")
config.font_size = 12.0

-- 配色（Catppuccin Mocha: カラフル系ダークテーマ）
config.color_scheme = "Catppuccin Mocha"

-- ウィンドウ
config.window_padding = {
  left = 10,
  right = 10,
  top = 8,
  bottom = 8,
}
config.window_background_opacity = 0.92

-- タブバーを下に移動
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.status_update_interval = 1000

-- タブバーのカラーカスタマイズ（Catppuccin Mocha 準拠）
config.colors = {
  tab_bar = {
    background = "#181825",
    active_tab = {
      bg_color = "#cba6f7", -- purple
      fg_color = "#1e1e2e",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#313244",
      fg_color = "#a6adc8",
    },
    inactive_tab_hover = {
      bg_color = "#45475a",
      fg_color = "#cdd6f4",
    },
    new_tab = {
      bg_color = "#181825",
      fg_color = "#585b70",
    },
    new_tab_hover = {
      bg_color = "#313244",
      fg_color = "#cdd6f4",
    },
  },
}

-- タブタイトルのフォーマット
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
  local title = tab.active_pane.title
  if tab.is_active then
    return {
      { Background = { Color = "#cba6f7" } },
      { Foreground = { Color = "#1e1e2e" } },
      { Attribute = { Intensity = "Bold" } },
      { Text = "  " .. title .. "  " },
    }
  elseif hover then
    return {
      { Background = { Color = "#45475a" } },
      { Foreground = { Color = "#cdd6f4" } },
      { Text = "  " .. title .. "  " },
    }
  else
    return {
      { Background = { Color = "#313244" } },
      { Foreground = { Color = "#a6adc8" } },
      { Text = "  " .. title .. "  " },
    }
  end
end)

-- ステータスバー（左: Git ブランチ / 右: 時刻）
wezterm.on("update-status", function(window, pane)
  -- 右: 時刻
  local time = wezterm.strftime(" %H:%M:%S ")
  window:set_right_status(wezterm.format({
    { Background = { Color = "#f38ba8" } }, -- red
    { Foreground = { Color = "#1e1e2e" } },
    { Attribute = { Intensity = "Bold" } },
    { Text = time },
  }))

  -- CWD を取得
  local cwd_uri = pane:get_current_working_dir()
  if not cwd_uri then
    window:set_left_status("")
    return
  end

  local cwd = cwd_uri.file_path or ""
  -- Windows: /C:/project -> C:/project
  if cwd:match("^/[A-Za-z]:") then
    cwd = cwd:sub(2)
  end

  -- Git ブランチ取得
  local ok, stdout = pcall(function()
    local success, out, _ = wezterm.run_child_process({
      "git", "-C", cwd, "branch", "--show-current",
    })
    if success then return out:gsub("\n", "") end
    return ""
  end)

  local branch = (ok and stdout ~= "") and stdout or ""

  if branch ~= "" then
    window:set_left_status(wezterm.format({
      { Background = { Color = "#a6e3a1" } }, -- green
      { Foreground = { Color = "#1e1e2e" } },
      { Attribute = { Intensity = "Bold" } },
      { Text = "  " .. branch .. "  " },
    }))
  else
    window:set_left_status("")
  end
end)

-- デフォルトのシェル（PowerShell 7）
config.default_prog = { "pwsh.exe" }
config.default_cwd = "C:/repos"

-- ランチャーメニュー（Alt+l で開く）
config.launch_menu = {
  { label = "Ubuntu", args = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" } },
}

-- キーバインド
config.keys = {
  { key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
  { key = "w", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}

return config
