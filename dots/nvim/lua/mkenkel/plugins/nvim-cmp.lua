return {
  "hrsh7th/nvim-cmp",
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
        {
          name = "luasnip",
          group_index = 1,
          option = { use_show_condition = true },
          entry_filter = function()
            local context = require("cmp.config.context")
            return not context.in_treesitter_capture("string")
                and not context.in_syntax_group("String")
          end,
        },
        {
          name = "nvim_lsp",
          group_index = 2,
        },
        {
          name = "nvim_lua",
          group_index = 3,
        },
        {
          name = "treesitter",
          keyword_length = 4,
          group_index = 4,
        },
        {
          name = "path",
          keyword_length = 4,
          group_index = 4,
        },
        {
          name = "buffer",
          keyword_length = 3,
          group_index = 5,
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end,
          },
        },
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
