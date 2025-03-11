return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'echasnovski/mini.icons',
  },

  config = function()
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    local schema = require("schema-companion").get_buffer_schema()
    vim.g.gitblame_display_virtual_text = 0
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = "",
        section_separators = "",
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          function()
            return ("%s"):format(require("schema-companion.context").get_buffer_schema().name)
          end,
          cond = function()
            return package.loaded["schema-companion"]
          end,
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { 'encoding' },
          { 'fileformat' },
          { 'filetype' },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end,
}
