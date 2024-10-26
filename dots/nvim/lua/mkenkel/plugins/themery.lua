return {
  --- Themes list
  "sainnhe/sonokai",
  "catppuccin/nvim",
  "ellisonleao/gruvbox.nvim",
  "rebelot/kanagawa.nvim",
  ---
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
          after = [[-- Same as before, but after if you need it]]
        },
      },
      livePreview = true, -- Apply theme while picking. Default to true.
    })
  end
}
