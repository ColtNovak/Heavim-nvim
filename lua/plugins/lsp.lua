return {
    { 
        "neovim/nvim-lspconfig",
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
          
          require("lspconfig").ts_ls.setup({ capabilities = capabilities })
          require("lspconfig").pyright.setup({ capabilities = capabilities })
        end
      },
      {
        "onsails/lspkind.nvim",
        lazy = true,
      },
      require'cmp'.setup {
        sources = {
          { name = 'nerdfont' }
        }
      }
}