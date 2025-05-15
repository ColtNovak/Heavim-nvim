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
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "horizontal",
        open_mapping = [[<leader>tt]],
        size = 15,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        persist_size = true,
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
      })
      
      -- Set leader to space (if not already set)
      vim.g.mapleader = " "
      vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
  {
    "nvim-tree/nvim-web-devicons",}
  }
