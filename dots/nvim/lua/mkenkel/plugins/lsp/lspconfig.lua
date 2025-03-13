return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { 'towolf/vim-helm',                     ft = 'helm' },
    "cenk1cenk2/schema-companion.nvim",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
  },

  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
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
        -- configure lua server (with special settings)
        require('lspconfig').lua_ls.setup {
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
        }
      end,
      ["nil_ls"] = function()
        -- configure lua server (with special settings)
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
        -- configure lua server (with special settings)
        lspconfig["taplo"].setup({
          cmd = { "taplo", "lsp", "stdio" },
          filetypes = { "toml" },
        })
      end,
      ["helm_ls"] = function()
        -- configure lua server (with special settings)
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
              -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
            }
          }
        })
      end,
      ["yamlls"] = function()
        -- configure lua server (with special settings)
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
                -- kubernetes = {
                --   "templates/*!(.gitlab-ci).{yml,yaml}",
                --   "workloads/**/*!(kustomization).{yml,yaml}",
                --   "*.k8s.{yml,yaml}",
                --   "daemon.{yml,yaml}",
                --   "manager.{yml,yaml}",
                --   "restapi.{yml,yaml}",
                --   "*namespace*.{yml,yaml}",
                --   "role.{yml,yaml}",
                --   "role-binding.{yml,yaml}",
                --   "*ingress*.{yml,yaml}",
                --   "*secret*.{yml,yaml}",
                --   "*deployment*.{yml,yaml}",
                --   "*service*.{yml,yaml}",
                --   "kubectl-edit*.yaml",
                -- },
                -- ["http://json.schemastore.org/chart"] = { "Chart.{yml,yaml}" },
                -- ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
                --   ".gitlab-ci.yml",
                -- },
                -- ["https://raw.githubusercontent.com/ansible-community/schemas/main/f/ansible-playbook.json"] = {
                --   "deploy.yml",
                --   "provision.yml",
                -- },
              },
            },
          },
        }))
      end,
    })
  end,
}
