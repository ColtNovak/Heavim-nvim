return {
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
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
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<leader>tt]],
        direction = "horizontal",
        persist_mode = true,
        auto_scroll = true,
      })
      
      vim.api.nvim_create_user_command("ToggleTerm", function()
        require("toggleterm").toggle()
      end, {})
    end
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = true
  }
}
