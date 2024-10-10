return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
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

    local keymap = vim
        .keymap                                                                                                         -- Initializing keymaps relative to plugins to keep things neater.

    keymap.set("n", "<leader>ef", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })                         -- toggle file explorer
    keymap.set("n", "<leader>ed", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })                     -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })                       -- refresh file explorer
  end
}
