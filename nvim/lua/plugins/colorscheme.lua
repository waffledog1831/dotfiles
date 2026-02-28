return {
  -- Catppuccin テーマ（WezTerm と統一）
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        telescope = { enabled = true },
        which_key = true,
        mason = true,
        mini = { enabled = true },
      },
    },
  },

  -- LazyVim のデフォルトカラースキームを Catppuccin Mocha に変更
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
