return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        {
          name = "Gruvbox dark",
          colorscheme = "gruvbox",
          before = [[
          -- All this block will be executed before apply "set colorscheme"
          vim.opt.background = "dark"
          ]],
        },
        {
          name = "Gruvbox light",
          colorscheme = "gruvbox",
          before = [[
            vim.opt.background = "light"
          ]],
          after = [[-- Same as before, but after if you need it]]
        },
        {
          name = "Catpuccinn Mocha",
          colorscheme = "catppuccin",
          before = [[
            vim.opt.background = "dark"
          ]],
          after = [[]]
        },
        {
          name = "Catpuccinn Light",
          colorscheme = "catppuccin",
          before = [[
            vim.opt.background = "light"
          ]],
          after = [[]]
        },
        {
          name = "Kanagawa Wave",
          colorscheme = "kanagawa-wave",
          before = [[
            vim.opt.background = "dark"
          ]],
          after = [[]]
        },
        {
          name = "Kanagawa Dragon",
          colorscheme = "kanagawa-dragon",
          before = [[
            vim.opt.background = "dark"
          ]],
          after = [[]]
        },
        {
          name = "Kanagawa Lotus",
          colorscheme = "kanagawa-lotus",
          before = [[
            vim.opt.background = "light"
          ]],
          after = [[]]
        },
        {
          name = "Sonokai",
          colorscheme = "sonokai",
          before = [[
            vim.opt.background = "dark"
          ]],
          after = [[]]
        },
      },
      livePreview = true, -- Apply theme while picking. Default to true.
    })
    local keymap = vim.keymap
    keymap.set("n", "<leader>tp", "<cmd>Themery<CR>", { desc = "Launch Themery" })
  end
}
