local M = {}
local api = vim.api
local devicons = require('tables._icons')
local icon
local file_name
local space = ' '
function M.get_file_icon(bufnr)
	--NOTE: Rather than use our internal bufname object
	--we use full filename to detect terminal windows
	file_name = api.nvim_buf_get_name(bufnr or 0)
	if string.find(file_name, 'term://') ~= nil then
		icon = ''..space
		return icon
	end
	icon = devicons.deviconTable[file_name]
	if icon ~= nil then
		return icon .. space
	else
		return ''
	end
end

return M
