return {
  'MeanderingProgrammer/render-markdown.nvim',
  after = { 'nvim-treesitter' },
  requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
  config = function()
    require('render-markdown').setup({
      completions = {
        file_types = { 'markdown', 'quarto' },
        render_modes = { 'n', 'c', 't' },
        lsp = {
          enabled = true
        }
      },
    })
  end,
}
