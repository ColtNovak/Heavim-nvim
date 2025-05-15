vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
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
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          return term.direction == "horizontal" and 15 or 80
        end,
        open_mapping = [[<leader>tt]],
        direction = "horizontal",
        persist_size = false,
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 3,
          width = function() return math.floor(vim.o.columns * 0.8) end,
          height = function() return math.floor(vim.o.lines * 0.8) end
        },
        highlights = {
          Normal = { link = "Normal" },
          NormalFloat = { link = "NormalFloat" },
          FloatBorder = { link = "FloatBorder" }
        }
      })

      -- Force create terminal command
      vim.api.nvim_create_user_command("ToggleTerm", function()
        require("toggleterm").toggle()
      end, {})
    end
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = true
  }
})

vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })

vim.cmd([[
  autocmd TermEnter * setlocal signcolumn=no
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal nonumber norelativenumber
]])
