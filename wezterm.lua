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

local config = {
   automatically_reload_config = false,
   check_for_updates = false,
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
   --font = wezterm.font_with_fallback {
   -- 'JetBrains Mono',
   -- 'Font Awesome',
   --},
   font = wezterm.font 'JetBrains Mono',
   --font = wezterm.font 'Iosevka Term Slab',
   font_size = 14,
   hide_tab_bar_if_only_one_tab = true,
   keys = {
      {
         key = 'R',
         mods = 'SHIFT|CTRL',
         action = wezterm.action.Search { CaseInSensitiveString = 'hash' },
      },
      {
         key = 'Enter',
         mods = 'ALT',
         action = wezterm.action.DisableDefaultAssignment,
      },
   },
   mouse_bindings = {
      {
         event = { Down = { streak = 1, button = { WheelUp = 1 } } },
         mods = 'NONE',
         action = wezterm.action.ScrollByLine(-3),
      },
      {
         event = { Down = { streak = 1, button = { WheelDown = 1 } } },
         mods = 'NONE',
         action = wezterm.action.ScrollByLine(3),
      },
      -- Ctrl + Scroll Up => Increase font size
      {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = "CTRL",
        action = wezterm.action.IncreaseFontSize,
      },
      -- Ctrl + Scroll Down => Decrease font size
      {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = "CTRL",
        action = wezterm.action.DecreaseFontSize,
      },
      -- Change the default click behavior so that it only selects text and doesn't open hyperlinks
      {
         event = { Up = { streak = 1, button = 'Left' } },
         mods = 'NONE',
         action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection',
      },
      -- and make CTRL-Click open hyperlinks
      {
         event = { Up = { streak = 1, button = 'Left' } },
         mods = 'CTRL',
         action = wezterm.action.OpenLinkAtMouseCursor,
      },
   },
   scrollback_lines = 10000,
   use_fancy_tab_bar = false,
   warn_about_missing_glyphs = false,
   window_close_confirmation = 'NeverPrompt',
   window_padding = {
      left = 0,
      --right = 15,
      right = 0,
      top = 0,
      bottom = 0,
   },
}

wezterm.on('update-status', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  overrides.enable_scroll_bar = not pane:is_alt_screen_active()
  window:set_config_overrides(overrides)
end)

--function recompute_padding(window)
--  local window_dims = window:get_dimensions()
--  local overrides = window:get_config_overrides() or {}

--  if not window_dims.is_full_screen then
--    if not overrides.window_padding then
--      -- not changing anything
--      return
--    end
--    overrides.window_padding = nil
--  else
--    -- Use only the middle 33%
--    local third = math.floor(window_dims.pixel_width / 3)
--    local new_padding = {
--      left = third,
--      right = third,
--      top = 0,
--      bottom = 0,
--    }
--    if
--      overrides.window_padding
--      and new_padding.left == overrides.window_padding.left
--    then
--      -- padding is same, avoid triggering further changes
--      return
--    end
--    overrides.window_padding = new_padding
--  end
--  window:set_config_overrides(overrides)
--end

--wezterm.on('window-resized', function(window, pane)
--  recompute_padding(window)
--end)

--wezterm.on('window-config-reloaded', function(window)
--  recompute_padding(window)
--end)

-- and finally, return the configuration to wezterm

-- For claude code multiline
config.keys = {
  {key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"}},
}

return config
