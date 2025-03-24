return {
  {
    "folke/which-key.nvim",
    config = function()
      require("config.whichkey").setup()
      require("which-key.health").check()
    end,
 
  }
}