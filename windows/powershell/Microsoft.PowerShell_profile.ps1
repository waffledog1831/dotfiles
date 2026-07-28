# ls のディレクトリ表示色（Catppuccin Mocha blue、背景色なし）
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.FromRgb(0x89, 0xb4, 0xfa)

# WezTerm: cd のたびに OSC 7 でCWDを通知する
# これにより WezTerm のステータスバー・タブタイトルのCWDがリアルタイムで更新される
function global:Prompt {
    $cwd = $PWD.ProviderPath -replace '\\', '/'
    if (-not $cwd.StartsWith('/')) { $cwd = "/$cwd" }
    [Console]::Write("`e]7;file://localhost$cwd`e\")
    "PS $($PWD.Path)> "
}
