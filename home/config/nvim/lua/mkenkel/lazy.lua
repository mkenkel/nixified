local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Grabs latest stable release of Lazy
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "mkenkel.plugins" }, { import = "mkenkel.plugins.lsp" } }, {
  change_detection = {
    notify = false, --Tells Lazy to stop asking about the changed files.
  },
})
