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
local config = require('modules.config')
local M = {}

------------------------------------------------------------------------
--                              Init                                  --
------------------------------------------------------------------------
function M.setup(user_config)
	config.setup(user_config)
	statusline.set_highlights()

	vim.api.nvim_create_augroup('StatuslineGroup', { clear = true })

	vim.api.nvim_create_autocmd('ColorScheme', {
		group = 'StatuslineGroup',
		callback = function()
			statusline.set_highlights()
		end,
	})

	vim.api.nvim_create_autocmd('BufEnter', {
		group = 'StatuslineGroup',
		callback = function()
			M.activeLine()
		end,
	})

	vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
		group = 'StatuslineGroup',
		callback = function()
			M.activeLine()
		end,
	})

	vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
		group = 'StatuslineGroup',
		callback = function()
			M.inActiveLine()
		end,
	})

	vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'WinLeave', 'BufLeave' }, {
		group = 'StatuslineGroup',
		pattern = 'NvimTree',
		callback = function()
			M.simpleLine()
		end,
	})

	vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
		group = 'StatuslineGroup',
		callback = function()
			M.tabline_init()
		end,
	})
end

------------------------------------------------------------------------
--                              DEPRECATION                                  --
------------------------------------------------------------------------
local function check_old_config()
	if M.inherit_colorscheme or M.tabline or M.lsp_diagnostics or M.ale_diagnostics then
		vim.api.nvim_echo({
			{
				"statusline.lua: [DEPRECATION NOTICE] 'statusline.inherit_colorscheme', 'statusline.tabline', 'statusline.lsp_diagnostics', and 'statusline.ale_diagnostics' are deprecated. Use 'statusline.setup()' instead. See README.md.",
				'WarningMsg',
			},
		}, true, {})

		-- Migrate old config values to the new setup method
		M.setup({
			inherit_colorscheme = M.inherit_colorscheme or false,
			tabline = M.tabline or false,
			lsp_diagnostics = M.lsp_diagnostics or false,
			ale_diagnostics = M.ale_diagnostics or false,
		})

		M.inherit_colorscheme = nil
		M.tabline = nil
		M.lsp_diagnostics = nil
		M.ale_diagnostics = nil
	end
end

-- Call the migration check when the module is required allowing user to set their config
vim.schedule(function()
	check_old_config()
end)
------------------------------------------------------------------------
--                              Statusline                            --
------------------------------------------------------------------------
function M.activeLine()
	if config.get().lsp_diagnostics == true then
		vim.wo.statusline = "%!v:lua.require'modules.statusline'.wants_lsp()"
	elseif config.get().ale_diagnostics == true then
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
	if config.get().tabline == true then
		vim.o.tabline = tabline.init()
	end
end

return M
