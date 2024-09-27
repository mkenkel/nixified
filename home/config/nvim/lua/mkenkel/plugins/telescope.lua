return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Module and submodule init
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = {
          "smart"
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,                     -- Move to previous result
            ["<C-j>"] = actions.move_selection_next,                         -- Move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- Send items to quickfix list???
          },
        },
      },

    })

    telescope.load_extension("fzf")

    -- Telescope Keybinds
    local keymap = vim.keymap -- Initializing keymaps relative to plugins to keep things neater.

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzyfind files in the cwd." })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzyfind recent files." })
    keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Fuzzyfind string in cwd." })
    keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor" }) -- Finds the word that the cursor is hovered over.
  end,
}
