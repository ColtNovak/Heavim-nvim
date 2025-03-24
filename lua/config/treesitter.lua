return {
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "c", "lua", "bash", "python", "rust", "javascript", "typescript",
      "vim", "vimdoc", "query", "markdown", "markdown_inline", "html",
      "css", "json", "toml", "yaml"
    },

    sync_install = false,
    auto_install = true,

    highlight = {
      enable = true,
      disable = function(lang, buf)
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
              return true
          end
      end,
      additional_vim_regex_highlighting = { "markdown" },
    },

    autotag = { enable = true }, 
    autopairs = { enable = true },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },

    indent = {
      enable = true,
      disable = { "python", "rust" } 
    },

    context_commentstring = {
      enable = true,
      enable_autocmd = false
    }
  },

  vim.cmd[[
    set selection=exclusive
    highlight Visual guibg=#3e4452 guifg=NONE
    highlight LineNr guifg=#5c6370 guibg=NONE
  ]]
}