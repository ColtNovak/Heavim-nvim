return { {
    "folke/snacks.nvim",
    priority = 1000,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("config.snacks.db")
      require("config.snacks")
    end,
  },
}