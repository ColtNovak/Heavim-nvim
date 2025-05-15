vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
    {
    'akinsho/toggleterm.nvim', 
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<leader>tt]],
        direction = "horizontal",
        close_on_exit = true,
        float_opts = {
          border = "curved",
          winblend = 3
        }
      })
    end
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = true
  }
})
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true
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
   

vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })

vim.cmd([[
  autocmd TermEnter * setlocal signcolumn=no
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal nonumber norelativenumber
]])
