return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      yaml = { "yamlfmt" },
      python = { "isort", "black" },
      nix = { "nixfmt " },
      toml = { "taplo" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      async = false,
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
