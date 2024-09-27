vim.cmd("let g:netrw_liststyle = 3") -- Tree-style file explorer for netrw

-- For any opt settings, if you have any questions, use ':help <name.of.opt.setting>' to view the man pages.

local opt = vim.opt

opt.relativenumber = true
opt.number = true -- Line numberings.

-- Tab and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true -- Do smart autoindenting when starting a new line.

opt.wrap = false

-- Search settings
opt.ignorecase = true -- ignore mixed case when searching
opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark" -- prefer dark backgrounds in color schemes if light/dark are both present.
opt.signcolumn = "yes"  -- Signs on the left of the editor

-- Backspace
opt.backspace = "indent,eol,start" -- Allows backspace on indent, EOL or insert mode start position.

-- Clipboard
opt.clipboard:append("unnamedplus") -- Use the system clipboard as the default register when copying/pasting.

-- Window Management
opt.splitright = true -- Prefer splitting to the right
opt.splitbelow = true -- Prefer splitting to the bottom
