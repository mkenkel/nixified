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

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")


    local keymap = vim.keymap -- Keybinds for lspconfig
    -- The command below automatically executes on the buffer attach.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

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
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
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
