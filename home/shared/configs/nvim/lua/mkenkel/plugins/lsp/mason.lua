return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    -- Import Mason
    local mason = require("mason")

    -- Import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- Enable Mason and configure the icons.
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- List of servers for Mason to install
      ensure_installed = {
        "ansiblels",
        "bashls",
        "docker_compose_language_service",
        "dockerls",
        "lua_ls",
        "terraformls",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "yamlfmt",
        "isort",
        "black",
        -- Linters below
        "ansible-lint",
        "pylint",
        "yamllint",
      }
    })
  end,
}
