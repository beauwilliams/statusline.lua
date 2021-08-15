local api = vim.api

local utils = {}

-- returns nil if not exists
function utils.is_dir(filepath)
	local ok, _ = os.rename(filepath, filepath)
	return ok
end

utils.Exists = function(variable)
	local loaded = api.nvim_call_function('exists', { variable })
	return loaded ~= 0
end

utils.Call = function(arg0, arg1)
	return api.nvim_call_function(arg0, arg1)
end

utils.IsVersion5 = function()
	return api.nvim_call_function('has', { 'nvim-0.5' }) == 1
end

return utils
