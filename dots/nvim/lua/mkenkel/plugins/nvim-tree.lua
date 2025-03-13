return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    { "n", "<leader>ef", "<cmd>NvimTreeToggle<CR>",         { desc = "Toggle file explorer" } },
    { "n", "<leader>ed", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" } },
    { "n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>",       { desc = "Collapse file explorer" } },
    { "n", "<leader>er", "<cmd>NvimTreeRefresh<CR>",        { desc = "Refresh file explorer" } },

  },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- optionally enable 24-bit colour
    vim.opt.termguicolors = true

    -- For all options, use ':h nvim-tree'
    require("nvim-tree").setup({
      actions = {
        open_file = {
          window_picker = {
            enable = false, -- Disable window_picker to work with window splits (might just enable in future)
          },
        },
      },
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 40,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
      git = {
        ignore = false,
      },
    })
  end
}
