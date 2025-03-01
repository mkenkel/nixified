return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
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
    })
  end,
}
