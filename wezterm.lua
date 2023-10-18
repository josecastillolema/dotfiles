-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
local config = {
   --automatically_reload_config = false,
   color_scheme = 'Materia (base16)',
   colors           	= {        	  -- color_scheme takes precedence over these
      scrollbar_thumb	= "grey"	, -- [#222222] The color of the scrollbar "thumb"; the portion that represents the current viewport
      --   ansi        	= {"black", "maroon", "green", "olive", "navy", "purple", "teal", "silver"},
      --   brights     	= {"grey", "red", "lime", "yellow", "blue", "fuchsia", "aqua", "white"},
      --   indexed     	= {[136]="#af8700"} , -- Arbitrary colors of the palette in the range from 16 to 255
   },
   -- because of https://github.com/wez/wezterm/issues/2445
   default_gui_startup_args = {'start', '--always-new-process'},
   enable_scroll_bar = true,
   --enable_wayland = false,
   font = wezterm.font 'JetBrains Mono',
   font_size = 14,
   window_close_confirmation = 'NeverPrompt',
   window_padding = {
      --  left = 2,
      right = 15,
      --  top = 0,
      --  bottom = 0,
   },
   hide_tab_bar_if_only_one_tab = true,
}

wezterm.on('update-status', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  overrides.enable_scroll_bar = not pane:is_alt_screen_active()
  window:set_config_overrides(overrides)     
end)

-- and finally, return the configuration to wezterm
return config
