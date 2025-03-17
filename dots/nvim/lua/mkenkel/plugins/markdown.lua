return {
  'MeanderingProgrammer/render-markdown.nvim',
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
  opts = {
    completions = {
      file_types = { 'markdown', 'quarto' },
      render_modes = { 'n', 'c', 't' },
      lsp = {
        enabled = true
      }
    },
  },
}
