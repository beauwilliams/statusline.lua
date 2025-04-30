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

local cmd = vim.api.nvim_command
local modes = require('tables._modes')
local git_branch = require('sections._git_branch')
local lsp = require('sections._lsp')
local signify = require('sections._signify')
local bufmod = require('sections._bufmodified')
local bufname = require('sections._bufname')
local buficon = require('sections._buficon')
local editable = require('sections._bufeditable')
local filesize = require('sections._filesize')
local M = {}

-- Separators
local left_separator = ''
local right_separator = ''

-- Blank Between Components
local space = ' '

------------------------------------------------------------------------
--                             Colours                                --
------------------------------------------------------------------------

-- Redraw different colors for different mode
local function set_mode_colours(mode)
	local colors = require('modules.colors').get()
	if mode == 'n' then
		cmd('hi Mode guibg=' .. colors.green .. ' guifg=' .. colors.black_fg .. ' gui=bold')
		cmd('hi ModeSeparator guifg=' .. colors.green)
	elseif mode == 'i' then
		cmd('hi Mode guibg=' .. colors.blue .. ' guifg=' .. colors.black_fg .. ' gui=bold')
		cmd('hi ModeSeparator guifg=' .. colors.blue)
	elseif mode == 'v' or mode == 'V' or mode == '^V' then
		cmd('hi Mode guibg=' .. colors.purple .. ' guifg=' .. colors.black_fg .. ' gui=bold')
		cmd('hi ModeSeparator guifg=' .. colors.purple)
	elseif mode == 'c' then
		cmd('hi Mode guibg=' .. colors.yellow .. ' guifg=' .. colors.black_fg .. ' gui=bold')
		cmd('hi ModeSeparator guifg=' .. colors.yellow)
	elseif mode == 't' then
		cmd('hi Mode guibg=' .. colors.red .. ' guifg=' .. colors.black_fg .. ' gui=bold')
		cmd('hi ModeSeparator guifg=' .. colors.red)
	end
end

function M.set_highlights()
	local colors = require('modules.colors').get()
	-- set Status_Line highlight
	cmd('hi StatusLine guibg=' .. colors.statusline_bg .. ' guifg=' .. colors.statusline_fg)
	-- set Statusline_LSP_Func highlight
	cmd('hi Statusline_LSP_Func guibg=' .. colors.statusline_bg .. ' guifg=' .. colors.statusline_fg)
	-- set InActive highlight
	cmd('hi InActive guibg=' .. colors.inactive_bg .. ' guifg=' .. colors.white_fg)
end

------------------------------------------------------------------------
--                              Statusline                            --
------------------------------------------------------------------------
function M.activeLine()
	local statusline = ''
	-- Component: Mode
	local mode = vim.api.nvim_get_mode()['mode']
	set_mode_colours(mode)
	statusline = statusline .. '%#ModeSeparator#' .. space
	statusline = statusline
		.. '%#ModeSeparator#'
		.. left_separator
		.. '%#Mode# '
		.. modes.current_mode[mode]
		.. ' %#ModeSeparator#'
		.. right_separator
		.. space
	-- Component: Filetype and icons
	statusline = statusline .. '%#Status_Line#' .. bufname.get_buffer_name()
	statusline = statusline .. buficon.get_file_icon()

	-- Component: errors and warnings -> requires ALE
	-- TODO: [beauwilliams] --> IMPLEMENT A LUA VERSION OF BELOW VIMSCRIPT FUNCS
	if diag_ale then
		statusline = statusline .. vim.call('LinterStatus')
	end

	-- Component: Native Nvim LSP Diagnostic
	if diag_lsp then
		statusline = statusline .. lsp.diagnostics()
	end

	-- TODO: SUPPORT COC LATER, NEEDS TESTING WITH COC USERS FIRST
	-- statusline = statusline..M.cocStatus()

	-- Component: git commit stats -> REQUIRES SIGNIFY
	statusline = statusline .. signify.signify()

	-- Component: git branch name -> requires FUGITIVE
	statusline = statusline .. git_branch.branch()

	--Component: Lsp Progress
	-- if lsp.lsp_progress()~= nil then
	statusline = statusline .. lsp.lsp_progress()
	statusline = statusline .. '%#Statusline_LSP_Func# ' .. lsp.lightbulb()
	-- end

	-- RIGHT SIDE INFO
	-- Alignment to left
	statusline = statusline .. '%='

	-- Component: LSP CURRENT FUCTION --> Requires LSP
	statusline = statusline .. '%#Statusline_LSP_Func# ' .. lsp.current_function()

	-- Scrollbar
	-- statusline = statusline.."%#Status_Line#"..vim.call('Scrollbar')..space

	-- Component: Modified, Read-Only, Filesize, Row/Col
	statusline = statusline .. '%#Status_Line#' .. bufmod.is_buffer_modified()
	statusline = statusline .. editable.editable() .. filesize.get_file_size() .. [[ʟ %l/%L c %c]] .. space
	cmd('set noruler') --disable line numbers in bottom right for our custom indicator as above
	return statusline
end

function M.wants_lsp()
	diag_lsp = true
	return M.activeLine(diag_lsp)
end

function M.wants_ale()
	diag_ale = true
	return M.activeLine(diag_ale)
end

-- statusline for simple buffers such as NvimTree where you don't need mode indicators etc
function M.simpleLine()
	local statusline = ''
	return statusline .. '%#Status_Line#' .. bufname.get_buffer_name() .. ''
end

------------------------------------------------------------------------
--                              Inactive                              --
------------------------------------------------------------------------

-- INACTIVE FUNCTION DISPLAY
function M.inActiveLine()
	local statusline = ''
	return statusline .. bufname.get_buffer_name() .. buficon.get_file_icon()
end

return M
