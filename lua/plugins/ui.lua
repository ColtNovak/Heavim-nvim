return {
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
      })
    end,
  },
    {'akinsho/toggleterm.nvim', version = "*", config = true},
  {
    "nvim-tree/nvim-web-devicons",}
  }
