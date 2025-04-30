------------------------------------------------------------------------
--                             Colours                                --
------------------------------------------------------------------------
local config = require('modules.config')

local M = {}

-- Default colours
local defaults = {
	-- Different colors for mode
	purple = '#BF616A', --#B48EAD
	blue = '#83a598', --#81A1C1
	yellow = '#fabd2f', --#EBCB8B
	green = '#8ec07c', --#A3BE8C
	red = '#fb4934', --#BF616A

	-- fg and bg
	white_fg = '#b8b894',
	black_fg = '#282c34',

	-- Inactive bg
	inactive_bg = '#1c1c1c',

	-- Statusline colour
	statusline_bg = 'NONE', -- Set to none, use native bg
	statusline_fg = 'NONE',
}

local colors = nil

local function get_color(group, key, fallback)
	local ok, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
	if not ok or not config.get().match_colorscheme then
		-- if not ok then
		return fallback
	end
	local color = hl[key]
	if not color then
		return fallback
	end
	return string.format('#%06x', color)
end

local function compute_colors()
	colors = {
		purple = get_color('Statement', 'foreground', defaults.purple),
		blue = get_color('Function', 'foreground', defaults.blue),
		yellow = get_color('Constant', 'foreground', defaults.yellow),
		green = get_color('String', 'foreground', defaults.green),
		red = get_color('Error', 'foreground', defaults.red),
		white_fg = get_color('Normal', 'foreground', defaults.white_fg),
		black_fg = get_color('Normal', 'background', defaults.black_fg),
		inactive_bg = get_color('NormalNC', 'background', defaults.inactive_bg),
		statusline_bg = defaults.statusline_bg,
		statusline_fg = defaults.statusline_fg,
	}
end

function M.get()
	if not colors then
		compute_colors()
	end
	return colors
end

function M.reset()
	colors = nil
end

return M
