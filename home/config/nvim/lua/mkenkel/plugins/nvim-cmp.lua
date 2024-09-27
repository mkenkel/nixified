return {
  {
    "hrsh7th/nvim-cmp"
  },
  {
    "github/copilot.vim"
  },
  event = "InsertEnter",  -- Whenever heading into insert mode, activate the extension.
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in the buffer.
    "hrsh7th/cmp-path",   -- source for filesystem pathing.
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
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

    -- Loads VSCode-like snippets from installed plugins (IE: friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
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
        { name = "luasnip" }, -- Snippets
        { name = "buffer" },  -- Text within the current buffer
        { name = "path" },    -- Filesystem Pathing
      }),
      -- Below configures LSPKind
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end
}
