local M = {}
local space = ' '
local vim = vim

function M.current_function()
	local lsp_function = vim.b.lsp_current_function
	if lsp_function == nil then
		return ''
	end
	return lsp_function..space
end

-- icons       
function M.diagnostics()
	local diagnostics = ''
	local has_vim_diagnostics, _ = pcall(require, 'vim.diagnostic')
	local has_lsp_diagnostics, _ = pcall(require, 'vim.lsp.diagnostic')
	local e, w, i, h
	if has_vim_diagnostics then
		local res = { 0, 0, 0, 0 }
		for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
			res[diagnostic.severity] = res[diagnostic.severity] + 1
		end
		e = res[vim.diagnostic.severity.ERROR]
		w = res[vim.diagnostic.severity.WARN]
		i = res[vim.diagnostic.severity.INFO]
		h = res[vim.diagnostic.severity.HINT]
	elseif has_lsp_diagnostics then
		e = vim.lsp.diagnostic.get_count(0, [[Error]])
		w = vim.lsp.diagnostic.get_count(0, [[Warning]])
		i = vim.lsp.diagnostic.get_count(0, [[Information]])
		h = vim.lsp.diagnostic.get_count(0, [[Hint]])
	else
		return ''
	end

	diagnostics = e ~= 0 and diagnostics .. ' ' .. e .. space or diagnostics
	diagnostics = w ~= 0 and diagnostics .. ' ' .. w .. space or diagnostics
	diagnostics = i ~= 0 and diagnostics .. ' ' .. i .. space or diagnostics
	diagnostics = h ~= 0 and diagnostics .. ' ' .. h .. space or diagnostics
	return diagnostics
end

local function format_messages(messages)
    local result = {}
    local spinners = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    local ms = vim.loop.hrtime() / 1000000
    local frame = math.floor(ms / 120) % #spinners

    table.insert(result, (messages.percentage or 0) .. '%% ' .. (messages.title or ""))
    return table.concat(result, ' ') .. ' ' .. spinners[frame + 1]
end

-- REQUIRES LSP
function M.lsp_progress()
    local clients = vim.lsp.get_active_clients()
    if vim.o.columns < 120 or #clients == 0 then
        return ""
    end

    local msg_val = nil
    vim.iter(clients):each(function(c)
        if msg_val then
            return
        end

        local msg = c.progress:pop()
        if msg and msg.value then
            msg_val = msg.value
        end
        -- Only display at most 2 progress messages at a time to avoid clutter
        local i = 1
        for pmsg in c.progress do
            if pmsg and pmsg.value and i < 3 then
                msg_val = pmsg.value
                i = i + 1
            end
        end
    end)

    if not msg_val then
        return ""
    end

    return space..format_messages(msg_val)
end

-- REQUIRES NVIM LIGHTBULB
function M.lightbulb()
	local has_lightbulb, lightbulb = pcall(require, 'nvim-lightbulb')
	if not has_lightbulb then
		return ''
	end

	if lightbulb.get_status_text() ~= '' then
		return '' .. space
	else
		return ''
	end
end

return M
