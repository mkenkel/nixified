return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "cenk1cenk2/schema-companion.nvim",
    { 'towolf/vim-helm',                     ft = 'helm' },
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
  },

  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,

      ["nil_ls"] = function()
        lspconfig["nil_ls"].setup({
          settings = {
            ['nil'] = {
              formatting = {
                command = { "nixfmt" },
              },
            },
          },
        })
      end,

      ["taplo"] = function()
        lspconfig["taplo"].setup({
          cmd = { "taplo", "lsp", "stdio" },
          filetypes = { "toml" },
        })
      end,

      ["helm_ls"] = function()
        lspconfig["helm_ls"].setup({
          logLevel = "info",
          valuesFiles = {
            mainValuesFile = "values.yaml",
            lintOverlayValuesFile = "values.lint.yaml",
            additionalValuesFilesGlobPattern = "values*.yaml"
          },
          yamlls = {
            enabled = true,
            enabledForFilesGlob = "*.{yaml,yml}",
            diagnosticsLimit = 50,
            showDiagnosticsDirectly = false,
            path = "yaml-language-server",
            config = {
              schemas = {
                kubernetes = "templates/**",
              },
              completion = true,
              hover = true,
            }
          }
        })
      end,

      ["yamlls"] = function()
        lspconfig["yamlls"].setup(require("schema-companion").setup_client({
          filetypes = {
            "yaml",
            "!yaml.ansible",
            "!yaml.docker-compose",
          },
          settings = {
            flags = {
              debounce_text_changes = 50,
            },
            redhat = { telemetry = { enabled = false } },
            yaml = {
              hover = true,
              completion = true,
              validate = true,
              format = { enable = false },
              schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
              schemaDownload = { enable = true },
              schemas = {
              },
            },
          },
        }))
      end,

    })
  end,
}
