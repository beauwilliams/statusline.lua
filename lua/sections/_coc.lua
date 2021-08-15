local utils = require('modules.utils')
local M = {}
-- neoclide/coc.nvim
function M.cocStatus()
	local cocstatus = ''
	if vim.fn.exists('*coc#status') == 0 then
		return ''
	end
	cocstatus = utils.Call('coc#status', {})
	return cocstatus
end
return M
