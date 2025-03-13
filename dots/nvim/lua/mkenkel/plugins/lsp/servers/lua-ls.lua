return {
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
}
