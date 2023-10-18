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
   enable_scroll_bar = true,
   --enable_wayland = false,
   font = wezterm.font 'JetBrains Mono',
   font_size = 14,
   inactive_pane_hsb = {
      hue = 0.5,
      saturation = 0.5,
      brightness = 0.5,
   },
   window_close_confirmation = 'NeverPrompt',
   window_padding = {
      --  left = 2,
      right = 15,
      --  top = 0,
      --  bottom = 0,
   },
   hide_tab_bar_if_only_one_tab = true,
}

-- and finally, return the configuration to wezterm
return config
