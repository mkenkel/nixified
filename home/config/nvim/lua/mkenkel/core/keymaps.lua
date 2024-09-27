vim.g.mapleader = " " -- Setting leader key as space

local keymap = vim.keymap

-- Insert Mode Hotkeys
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" }) -- This keymap will only work in insert mode

-- Normal Mode Hotkeys
keymap.set("n", "<leader>ch", ":nohl<CR>", { desc = "Clear search highlights" }) -- This keymap works whenever

-- Number control
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window Manager Stuff (VIM-Specific)
-- Window Spawning and Closing
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split Window Vertically" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split Window Horizontally" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Equalize Split Size" })
keymap.set("n", "<leader>wk", "<cmd>close<CR>", { desc = "Close the Current Split Window" })

-- Window Navigation (TBD)

-- Tab control
keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New Tab" })
keymap.set("n", "<leader>tk", "<cmd>tabclose<CR>", { desc = "Kill Tab" })
keymap.set("n", "<leader>t.", "<cmd>tabn<CR>", { desc = "Cycle to next tab" })
keymap.set("n", "<leader>t,", "<cmd>tabp<CR>", { desc = "Cycle to previous tab" })
keymap.set("n", "<leader>tnb", "<cmd>tabnew %<CR>", { desc = "Send current buffer to new tab" })

keymap.set("n", "<leader>af", "<cmd>!ansible-lint --fix %<CR>",
  { desc = "Runs ansible-lint against the file", noremap = true, silent = true })

-- Personal timesavers
keymap.set("n", "<leader>wq", "<cmd>wq! <CR>", { desc = "Write and quit the file." })
keymap.set("n", "<leader>qq", "<cmd>q! <CR>", { desc = "Quick quit (No save)" })
