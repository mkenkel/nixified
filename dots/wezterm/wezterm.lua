-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Essentials
config.enable_wayland = false
config.front_end = "WebGpu"

-- Fonts
config.font = wezterm.font 'Maple Mono SC NF'

-- Animation FPS
config.animation_fps = 120
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.color_scheme = 'Cai'

-- and finally, return the configuration to wezterm
return config
