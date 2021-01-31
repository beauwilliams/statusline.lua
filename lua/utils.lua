
local api = vim.api

local Utils = {}

local function map(type, input, output)
    api.nvim_set_keymap(type, input, output, {})
end

local function noremap(type, input, output)
    api.nvim_set_keymap(type, input, output, { noremap = true })
end

function nnoremap(input, output)
    noremap('n', input, output)
end

function inoremap(input, output)
    noremap('i', input, output)
end

function vnoremap(input, output)
    noremap('v', input, output)
end

function tnoremap(input, output)
    noremap('t', input, output)
end

function nmap(input, output)
	map('n', input, output)
end

function imap(input, output)
	map('i', input, output)
end

function vmap(input, output)
	map('v', input, output)
end

function tmap(input, output)
	map('t', input, output)
end

-- returns nil if not exists
function Utils.is_dir(filepath)
    local ok, _ = os.rename(filepath, filepath)
    return ok
end


Utils.Exists = function(variable)
    local loaded = api.nvim_call_function('exists', {variable})
    return loaded ~= 0
end

Utils.Call = function(arg0, arg1)
    return api.nvim_call_function(arg0, arg1)
end

Utils.IsVersion5 = function()
    return api.nvim_call_function('has', {'nvim-0.5'}) == 1
end

return Utils
