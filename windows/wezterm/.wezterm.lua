local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- フォント
config.font = wezterm.font("Cascadia Code")
config.font_size = 12.0

-- 配色（Catppuccin Mocha ベース）
config.color_scheme = "Catppuccin Mocha"

-- ウィンドウ
config.window_decorations = "TITLE | RESIZE"
config.window_padding = { left = 10, right = 10, top = 8, bottom = 8 }

config.window_background_opacity = 0.92

-- カーソル（ブリンクバー）
config.default_cursor_style = "BlinkingBar"

-- タブバー（retro モード・下に配置）
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.status_update_interval = 500

-- タブバーのベースカラー
config.colors = {
  tab_bar = {
    background = "#11111b",
    active_tab = { bg_color = "#cba6f7", fg_color = "#1e1e2e", intensity = "Bold" },
    inactive_tab = { bg_color = "#1e1e2e", fg_color = "#585b70" },
    inactive_tab_hover = { bg_color = "#313244", fg_color = "#cdd6f4" },
    new_tab = { bg_color = "#11111b", fg_color = "#585b70" },
    new_tab_hover = { bg_color = "#313244", fg_color = "#cdd6f4" },
  },
}

-- A: タブインデックスで色をローテーション（Catppuccin アクセントカラー）
local TAB_COLORS = {
  "#cba6f7", -- mauve
  "#89b4fa", -- blue
  "#a6e3a1", -- green
  "#fab387", -- peach
  "#89dceb", -- sky
  "#f38ba8", -- red
  "#94e2d5", -- teal
  "#f9e2af", -- yellow
}

-- タブタイトル（虹色）
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
  local title = tab.active_pane.title
  local color = TAB_COLORS[(tab.tab_index % #TAB_COLORS) + 1]

  -- タイトルを12文字に収める
  local short = #title > 12 and (title:sub(1, 12) .. "…") or title

  if tab.is_active then
    return {
      { Background = { Color = color } },
      { Foreground = { Color = "#1e1e2e" } },
      { Attribute = { Intensity = "Bold" } },
      { Text = "  " .. short .. "  " },
    }
  elseif hover then
    return {
      { Background = { Color = "#313244" } },
      { Foreground = { Color = color } },
      { Text = "  " .. short .. "  " },
    }
  else
    return {
      { Background = { Color = "#1e1e2e" } },
      { Foreground = { Color = color } },
      { Text = "  " .. short .. "  " },
    }
  end
end)

-- CWD 絵文字（ディレクトリ名に応じてランダムに固定割り当て）
local CWD_EMOJIS = { "🌸", "🚀", "🌈", "⚡", "🎪", "🌊", "🔥", "🎸", "🌙", "🎨", "🦋", "🍀", "🎯", "🐉", "🎭" }
local function cwd_emoji(s)
  local h = 0
  for i = 1, #s do h = (h * 31 + s:byte(i)) % 9999 end
  return CWD_EMOJIS[(h % #CWD_EMOJIS) + 1]
end

-- テーマ定義（10分ごとにローテーション）
local THEMES = {
  { color = "#f9e2af", frames = { -- ⭐ 星
    { "✦", "✧", "·" }, { "✧", "·", "✦" }, { "·", "✦", "✧" },
    { "✨", "·", "✧" }, { "·", "✨", "✦" }, { "✦", "·", "✨" },
  }},
  { color = "#89dceb", frames = { -- 🌊 海
    { "〜", "≈", "·" }, { "≈", "·", "〜" }, { "·", "〜", "≈" },
    { "∿", "·", "≈" },  { "·", "∿", "〜" }, { "〜", "·", "∿" },
  }},
  { color = "#f38ba8", frames = { -- 🌸 花
    { "✿", "❀", "·" }, { "❀", "·", "✿" }, { "·", "✿", "❀" },
    { "❁", "·", "❀" }, { "·", "❁", "✿" }, { "✿", "·", "❁" },
  }},
  { color = "#89b4fa", frames = { -- ❄ 雪
    { "❄", "❅", "·" }, { "❅", "·", "❄" }, { "·", "❄", "❅" },
    { "❆", "·", "❅" }, { "·", "❆", "❄" }, { "❄", "·", "❆" },
  }},
  { color = "#a6e3a1", frames = { -- ♪ 音楽
    { "♪", "♫", "·" }, { "♫", "·", "♪" }, { "·", "♪", "♫" },
    { "♬", "·", "♫" }, { "·", "♬", "♪" }, { "♪", "·", "♬" },
  }},
  { color = "#cba6f7", frames = { -- 💎 宝石
    { "◆", "◇", "·" }, { "◇", "·", "◆" }, { "·", "◆", "◇" },
    { "◈", "·", "◇" }, { "·", "◈", "◆" }, { "◆", "·", "◈" },
  }},
  { color = "#f38ba8", frames = { -- ❤ ハート
    { "♥", "♡", "·" }, { "♡", "·", "♥" }, { "·", "♥", "♡" },
    { "❤", "·", "♡" }, { "·", "❤", "♥" }, { "♥", "·", "❤" },
  }},
  { color = "#a6e3a1", frames = { -- 🌿 草木
    { "✿", "✾", "·" }, { "✾", "·", "✿" }, { "·", "✿", "✾" },
    { "✱", "·", "✾" }, { "·", "✱", "✿" }, { "✿", "·", "✱" },
  }},
}
local THEME_INTERVAL = 10 * 60 -- 10分ごとに切替

-- ステータスバー（左: CWD / 右: テーマフレーム）
wezterm.on("update-status", function(window, pane)
  local t = os.time()
  -- テーマ選択（10分ごと + タブIDでオフセット → タブ切替でも変わる）
  local tab_id = window:active_tab():tab_id()
  local theme = THEMES[(math.floor(t / THEME_INTERVAL) + tab_id) % #THEMES + 1]
  -- フレーム選択（1秒ごと）
  local s = theme.frames[(t % #theme.frames) + 1]
  local sl = s[1] .. " " .. s[2] .. " " .. s[3]
  local sr = s[3] .. " " .. s[2] .. " " .. s[1]

  -- 右: テーマカラーで表示
  window:set_right_status(wezterm.format({
    { Background = { Color = "#11111b" } },
    { Foreground = { Color = theme.color } },
    { Text = " " .. sl .. "  " .. sr .. " " },
  }))

  -- CWD を取得
  local cwd_uri = pane:get_current_working_dir()
  if not cwd_uri then
    window:set_left_status(wezterm.format({
      { Background = { Color = "#89b4fa" } },
      { Foreground = { Color = "#1e1e2e" } },
      { Text = "  ~  " },
    }))
    return
  end

  local cwd = cwd_uri.file_path or ""
  if cwd:match("^/[A-Za-z]:") then
    cwd = cwd:sub(2)
  end

  -- 最後のディレクトリ名だけ表示
  local short_cwd = cwd:match("([^/\\]+)[/\\]?$") or cwd

  local left = {}

  for _, v in ipairs({
    { Background = { Color = "#89b4fa" } },
    { Foreground = { Color = "#1e1e2e" } },
    { Attribute = { Intensity = "Normal" } },
    { Text = " " .. cwd_emoji(short_cwd) .. " " .. short_cwd .. "  " },
  }) do table.insert(left, v) end

  window:set_left_status(wezterm.format(left))
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
  {
    key = "a",
    mods = "ALT",
    action = wezterm.action.SpawnCommandInNewTab({
      args = { "pwsh.exe", "-NoExit", "-Command", "claude --agent lilia" },
    }),
  },
}

return config
