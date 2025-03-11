return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'echasnovski/mini.icons',
  },

  config = function()
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    local function get_schema()
      local schema = require("schema-companion").get_buffer_schema(0)
      if schema.result[1].name == "none" then
        return ""
      end
      return schema.result[1].name
    end
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
        lualine_c = {},
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { 'encoding' },
          { 'fileformat' },
          { 'filetype' },
          { get_schema },
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
