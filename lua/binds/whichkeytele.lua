local M = {}

function M.setup()
  local wk = require("which-key")
  local ts = require("telescope.builtin")
  local act = require("telescope.actions")
  local state = require("telescope.actions.state")

  local layout = {
    height = 0.8,
    width = 0.9,
    prompt_position = "top"
  }
  local prompt = {
    height = 0.6,
    width = 0.5,
  }

  local function show_helper()
    require("telescope.pickers").new({
      prompt_title = " Quick Helper ",
      finder = require("telescope.finders").new_table({
        results = { "keymaps", "commands" },
        entry_maker = function(item)
          return {
            value = item,
            display = "󰌌 " .. item,
            ordinal = item
          }
        end
      }),
      sorter = require("telescope.config").values.generic_sorter({}),
      attach_mappings = function(buf)
        act.select_default:replace(function()
          local choice = state.get_selected_entry().value
          act.close(buf)
          ts[choice]({ layout_strategy = "vertical", layout_config = layout })
        end)
        return true
      end,
      previewer = false,
      layout_strategy = "vertical",
      layout_config = prompt
    }):find()
  end

  wk.register({ [","] = { show_helper, "Quick helper" } }, { prefix = "<leader>" })

  wk.register({
    ["<leader>"] = {
      f = { name = "Files", f = ts.find_files, g = ts.live_grep, b = ts.buffers },
      g = { name = "Git", c = ts.git_commits, b = ts.git_branches },
      l = { name = "LSP", d = ts.lsp_definitions, r = ts.lsp_references }
    }
  })
end

return M