return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

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
      ensure_installed = {
        "ansiblels",
        "bashls",
        "docker_compose_language_service",
        "dockerls",
        "lua_ls",
        "nil_ls",
        "helm_ls",
        "taplo",
        "terraformls",
        "nim_langserver",
        "yamlls",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "ansible-lint",
        "black",
        "isort",
        "prettier",
        "pylint",
        "yamllint",
        "yamlfmt",
      }
    })
  end,
}
