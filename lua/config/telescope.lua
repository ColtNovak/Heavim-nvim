local M = {}

function M.setup()
  require("telescope").setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<ESC>"] = require("telescope.actions").close
        }
      },
      layout_config = {
        width = 0.8,
        height = 0.6,
        preview_cutoff = 50
      }
    },
    pickers = {
      commands = {
        theme = "cursor",
        layout_config = {
          width = 0.9,
          height = 0.3
        }
      },
      keymaps = {
        theme = "dropdown",
        layout_config = {
          prompt_position = "top"
        }
      }
    }
  })
end

return M