return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("config.telescope").setup()
    end,
    keys = {
      { "<leader>,", desc = "Browse Keybinds" },
      { "<leader>ff", desc = "Find Files" },
      { "<leader>fg", desc = "Live Grep" }
    }
  }
}