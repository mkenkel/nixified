return {
  "FabijanZulj/blame.nvim",
  lazy = false,
  config = function()
    require('blame').setup {}
  end,
  keys = {
    { '<leader>gb', '<cmd>BlameToggle<cr>', desc = 'Blame - Toggle' },
  },
}
