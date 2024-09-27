return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- Lazy.NVIM knows with this that it can load later as it's not important for the UI.
  init = function()   -- Runs when Neovim starts up vs when the plugin loads
    vim.o.timeout = true
    vim.o.timeoutlen = 100
  end,
  opts = {
    -- Loads default config if nothing is present.
  },
}
