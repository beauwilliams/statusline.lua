------------------------------------------------------------------------
--                              TabLine                               --
------------------------------------------------------------------------
local M = {}

local api = vim.api
local cmd = api.nvim_command
local icons = require('tables._icons')
local config = require('modules.config')

-- Separators
local left_separator = ''
local right_separator = ''
local space = ' '

local TrimmedDirectory = function(dir)
	local home = os.getenv('HOME')
	local _, index = string.find(dir, home, 1)
	if index ~= nil and index ~= string.len(dir) then
		if string.len(dir) > 30 then
			dir = '..' .. string.sub(dir, 30)
		end
		return string.gsub(dir, home, '~')
	end
	return dir
end

local getTabLabel = function(n)
	local current_win = api.nvim_tabpage_get_win(n)
	local current_buf = api.nvim_win_get_buf(current_win)
	local file_name = api.nvim_buf_get_name(current_buf)
	if string.find(file_name, 'term://') ~= nil then
		return ' ' .. api.nvim_call_function('fnamemodify', { file_name, ':p:t' })
	end
	file_name = api.nvim_call_function('fnamemodify', { file_name, ':p:t' })
	if file_name == '' then
		return 'No Name'
	end
	local icon = icons.deviconTable[file_name]
	if icon ~= nil then
		return icon .. space .. file_name
	end
	return file_name
end

local set_colours = function()
	local colors = require('modules.colors').get()
	cmd('hi TabLineSel gui=Bold guibg=' .. colors.green .. ' guifg=' .. colors.black_fg)
	cmd('hi TabLineSelSeparator gui=bold guifg=' .. colors.green)
	cmd('hi TabLine guibg=' .. colors.inactive_bg .. ' guifg=' .. colors.white_fg .. ' gui=None')
	cmd('hi TabLineSeparator guifg=' .. colors.inactive_bg)
	cmd('hi TabLineFill guibg=None gui=None')
end

function M.init()
	if not config.get().tabline then
		return ''
	end

	set_colours()
	local tabline = ''
	local tab_list = api.nvim_list_tabpages()
	local current_tab = api.nvim_get_current_tabpage()

	for _, val in ipairs(tab_list) do
		local file_name = getTabLabel(val)
		if val == current_tab then
			tabline = tabline .. '%#TabLineSelSeparator# ' .. left_separator
			tabline = tabline .. '%#TabLineSel# ' .. file_name
			tabline = tabline .. ' %#TabLineSelSeparator#' .. right_separator
		else
			tabline = tabline .. '%#TabLineSeparator# ' .. left_separator
			tabline = tabline .. '%#TabLine# ' .. file_name
			tabline = tabline .. ' %#TabLineSeparator#' .. right_separator
		end
	end

	tabline = tabline .. '%='
	local dir = api.nvim_call_function('getcwd', {})
	tabline = tabline
		.. '%#TabLineSeparator#'
		.. left_separator
		.. '%#Tabline# '
		.. TrimmedDirectory(dir)
		.. '%#TabLineSeparator#'
		.. right_separator

	tabline = tabline .. space
	return tabline
end

return M
