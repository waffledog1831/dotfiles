-- Nerd Font を使わない（フォントインストール不要）
vim.g.have_nerd_font = false

-- Windows: PowerShell 7 をデフォルトシェルに
if vim.fn.has("win32") == 1 then
  vim.opt.shell = "pwsh"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellpipe = "| Out-File -Encoding UTF8 %s"
  vim.opt.shellredir = "| Out-File -Encoding UTF8 %s"
  vim.opt.shellxquote = ""
end
