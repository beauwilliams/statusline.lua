--[[
   _____  ______    ___   ______   __  __   _____    __     ____    _   __    ______
  / ___/ /_  __/   /   | /_  __/  / / / /  / ___/   / /    /  _/   / | / /   / ____/
  \__ \   / /     / /| |  / /    / / / /   \__ \   / /     / /    /  |/ /   / __/
 ___/ /  / /     / ___ | / /    / /_/ /   ___/ /  / /___ _/ /    / /|  /   / /___
/____/  /_/     /_/  |_|/_/     \____/   /____/  /_____//___/   /_/ |_/   /_____/
--]]
------------------------------------------------------------------------
--                             Variables                              --
------------------------------------------------------------------------

local tabline = require('modules.tabline')
local statusline = require('modules.statusline')
local M = {}
M.tabline = true -- Default to true
M.lsp_diagnostics = true -- Enable Nvim native LSP as default
M.ale_diagnostics = false -- Disable Ale by default

------------------------------------------------------------------------
--                              Init                            --
------------------------------------------------------------------------
function M.statusline_init()
  statusline.set_highlights()
end


------------------------------------------------------------------------
--                              Statusline                            --
------------------------------------------------------------------------
function M.activeLine()
	if M.lsp_diagnostics == true then
		vim.wo.statusline = "%!v:lua.require'modules.statusline'.wants_lsp()"
	elseif M.ale_diagnostics == true then
		vim.wo.statusline = "%!v:lua.require'modules.statusline'.wants_ale()"
	else
		vim.wo.statusline = "%!v:lua.require'modules.statusline'.activeLine()"
	end
end

function M.simpleLine()
	vim.wo.statusline = statusline.simpleLine()
end

------------------------------------------------------------------------
--                              Inactive                              --
------------------------------------------------------------------------

function M.inActiveLine()
	vim.wo.statusline = statusline.inActiveLine()
end

------------------------------------------------------------------------
--                        Tabline Config                              --
------------------------------------------------------------------------
M.tabline_init = function()
	if M.tabline == true then
		vim.o.tabline = tabline.init()
	end
end

return M
