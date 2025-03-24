return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
    
              end,
      },
      {
        "zbirenbaum/copilot-cmp",
        config = function ()
          require("copilot_cmp").setup()
        end
      },
      
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "L3MON4D3/LuaSnip",
          "hrsh7th/cmp-nvim-lsp",
            "zbirenbaum/copilot-cmp",
            "zbirenbaum/copilot.lua",
        },
        config = function()
          local cmp = require("cmp")
          cmp.setup({
            sources = cmp.config.sources({
                  { name = "copilot", group_index = 2 },
    
              { name = "nvim_lsp" },
              { name = "luasnip" },
                }),
            snippet = {
              expand = function(args)
                require("luasnip").lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            formatting = {
              format = require("lspkind").cmp_format({
                mode = "symbol_text",
                maxwidth = 50,
              }),
            },
          })
        end,
      },
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
   
    
}