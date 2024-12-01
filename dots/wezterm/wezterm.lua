-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Tabline
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- Essentials
config.enable_wayland = false
config.front_end = "WebGpu"

-- Fonts
config.font = wezterm.font 'Maple Mono SC NF'
config.font_size = 20.0

-- Animation FPS
config.animation_fps = 120
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.use_fancy_tab_bar = false

config.color_scheme = 'ayu'
-- The filled in variant of the < symbol

tabline.setup({
  options = {
    icons_enabled = true,
    theme = 'Catppuccin Mocha',
    color_overrides = {},
    section_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
    },
    component_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thin,
      right = wezterm.nerdfonts.ple_left_half_circle_thin,
    },
    tab_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
    },
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = { 'workspace' },
    tabline_c = { ' ' },
    tab_active = {
      'index',
      { 'parent', padding = 0 },
      '/',
      { 'cwd',    padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = { 'index', { 'process', padding = { left = 0, right = 1 } } },
    tabline_x = { 'ram', 'cpu' },
    tabline_y = { 'datetime', 'battery' },
    tabline_z = { 'hostname' },
  },
  extensions = {},
})

return config
