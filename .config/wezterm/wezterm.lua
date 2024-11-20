local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true

-- Theme
config.font = wezterm.font("JetBrains Mono")
config.font_size = 18.0
config.color_scheme = "tokyonight_night"
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.initial_rows = 46
config.initial_cols = 64
config.window_frame = {
	font = config.font,
	font_size = config.font_size,
	inactive_titlebar_bg = "#353535",
	active_titlebar_bg = "#181721",
}

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab)
	local title = tab_title(tab)
	if tab.is_active then
		return {
			{ Background = { Color = "#1C1B28" } },
			{ Foreground = { Color = "#6c7086" } },
			{ Text = " " .. tab.tab_index + 1 .. ". " },

			{ Foreground = { Color = "#89b4fa" } },
			{ Attribute = { Intensity = "Bold" } },
			{ Text = title .. " " },
		}
	end
	return {
		{ Background = { Color = "#11111b" } },
		{ Foreground = { Color = "#6c7086" } },
		{ Text = tab.tab_index + 1 .. ". " .. title },
	}
end)

-- Keybindings
config.leader = { key = "Home", timeout_milliseconds = 1000 }

return config
