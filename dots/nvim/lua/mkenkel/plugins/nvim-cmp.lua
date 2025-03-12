return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",  -- Whenever heading into insert mode, activate the extension.
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in the buffer.
    "hrsh7th/cmp-path",   -- source for filesystem pathing.
    "hrsh7th/cmp-nvim-lua",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",     -- Autocompletion.
    "rafamadriz/friendly-snippets", -- Useful snippets.
    "onsails/lspkind.nvim",         -- VSCode like pictograms?
  },
  config = function()
    local luasnip = require("luasnip")
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),        -- Previous selection
        ["<C-j>"] = cmp.mapping.select_next_item(),        -- Next selection
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),           -- Scroll backwards
        ["<C-f>"] = cmp.mapping.scroll_docs(4),            -- Scroll forwards
        ["<C-Space>"] = cmp.mapping.complete(),            -- Show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(),                   -- Close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- huh?
      }),
      -- Sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua", priority = 100 },
        { name = "vsnip" },
        { name = "buffer" },
        { name = "emoji" },
        { name = "path" },
        { name = "crates" },
        { name = "snippets" },
        { name = "projects", priority = 100 },
      }),
      -- Below configures LSPKind
      formatting = {
        expandable_indicator = true,
        fields = {
          "abbr",
          "kind",
          "menu",
        },
        format = lspkind.cmp_format({
          mode = "symbol_text",  -- Use "symbol" to only show the icon or "symbol_text" for both icon and text
          maxwidth = 50,         -- Optional, for max width of the displayed item
          ellipsis_char = "...", -- Optional, truncate the item if it's too long
          menu = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            projects = "[Projects]",
            emoji = "[Emoji]",
            vsnip = "[Snippet]",
          },
        }),
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })
  end
}
