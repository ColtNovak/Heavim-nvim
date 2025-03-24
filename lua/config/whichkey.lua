local M = {}

function M.setup()
  require("which-key").setup()

  require("binds.whichkeytele").setup()
  require("which-key.health").check()

end

return M