
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

-- TODO--> [beauwilliams] --> Better handling of data
local api = vim.api
local cmd = api.nvim_command
local call = vim.call
local func = api.nvim_call_function
local modes = require 'tables._modes'
local git_branch = require 'sections._git_branch'
local lsp = require 'sections._lsp'
local signify = require 'sections._signify'
local bufmod = require 'sections._bufmodified'
local bufname = require 'sections._bufname'
local buficon = require 'sections._buficon'
local editable = require 'sections._bufeditable'
local filesize = require 'sections._filesize'
local tabline = require'modules.tabline'
local M = {}
M.tabline = true -- Default to true


-- Separators
local left_separator = ''
local right_separator = ''

-- Blank Between Components
local space = ' '

-- Icons (future use)
-- local warningIcon = ''
-- local exclamationIcon = ''
-- local plusIcon = ''
-- local tildeIcon = 'ﰣ'
-- local minusIcon = ''
-- local errorIcon =''

------------------------------------------------------------------------
--                             Colours                                --
------------------------------------------------------------------------

-- Different colors for mode
local purple = '#BF616A' --#B48EAD
local blue = '#83a598' --#81A1C1
local yellow = '#fabd2f' --#EBCB8B
local green = '#8ec07c' --#A3BE8C
local red = '#fb4934' --#BF616A

-- fg and bg
local white_fg = '#b8b894'
local black_fg = '#282c34'
local mybg = '#504945'


--Statusline colour
local statusline_bg = 'None' --> Set to none, use native bg
local statusline_fg = white_fg
-- local statusline_font = 'regular'
cmd('hi Status_Line guibg='..statusline_bg..' guifg='..statusline_fg)

--LSP Function Highlight Color
cmd('hi Statusline_LSP_Func guibg='..statusline_bg..' guifg='..green)


-- INACTIVE BUFFER Colours
local InactiveLine_bg = '#1c1c1c'
local InactiveLine_fg = white_fg
cmd('hi InActive guibg='..InactiveLine_bg..' guifg='..InactiveLine_fg)


-- Redraw different colors for different mode
local set_mode_colours = function(mode)
  if mode == 'n' then
    cmd('hi Mode guibg='..green..' guifg='..black_fg..' gui=bold')
    cmd('hi ModeSeparator guifg='..green)
  end
  if mode == 'i' then
    cmd('hi Mode guibg='..blue..' guifg='..black_fg..' gui=bold')
    cmd('hi ModeSeparator guifg='..blue)
  end
  if mode == 'v' or mode == 'V' or mode == '^V' then
    cmd('hi Mode guibg='..purple..' guifg='..black_fg..' gui=bold')
    cmd('hi ModeSeparator guifg='..purple)
  end
  if mode == 'c' then
    cmd('hi Mode guibg='..yellow..' guifg='..black_fg..' gui=bold')
    cmd('hi ModeSeparator guifg='..yellow)
  end
  if mode == 't' then
    cmd('hi Mode guibg='..red..' guifg='..black_fg..' gui=bold')
    cmd('hi ModeSeparator guifg='..red)
  end
end


------------------------------------------------------------------------
--                              Statusline                            --
------------------------------------------------------------------------
function M.activeLine()
  local statusline = ""
  -- Component: Mode
  local mode = api.nvim_get_mode()['mode']
  set_mode_colours(mode)
  statusline = statusline.."%#ModeSeparator#"..space
  statusline = statusline.."%#ModeSeparator#"..left_separator.."%#Mode# "..modes.current_mode[mode].." %#ModeSeparator#"..right_separator..space
  -- Component: Filetype and icons
  statusline = statusline.."%#Status_Line#"..bufname.get_buffer_name()
  statusline = statusline..buficon.get_file_icon()

  -- Component: errors and warnings -> requires ALE
  -- TODO--> [beauwilliams] --> IMPLEMENT A LUA VERSION OF BELOW VIMSCRIPT FUNCS
  statusline = statusline..call('LinterStatus')
  -- TODO--> SUPPORT COC LATER, NEEDS TESTING WITH COC USERS FIRST
  -- statusline = statusline..M.cocStatus()

  -- Component: git commit stats -> REQUIRES SIGNIFY
  statusline = statusline..signify.signify()


  -- Component: git branch name -> requires FUGITIVE
  statusline = statusline..git_branch.branch()

  -- Alignment to left
  statusline = statusline.."%="

  -- Component: LSP CURRENT FUCTION --> Requires LSP
  statusline = statusline.."%#Statusline_LSP_Func# "..lsp.lsp_current_function()

  -- RIGHT SIDE INFO
  -- Component: Modified, Read-Only, Filesize, Row/Col
  statusline = statusline.."%#Status_Line#"..bufmod.is_buffer_modified()
  statusline = statusline..editable.editable()..filesize.get_file_size()..[[ʟ %l/%L c %c]]..space
  cmd('set noruler') --disable line numbers in bottom right for our custom indicator as above

  return statusline
end


------------------------------------------------------------------------
--                              Inactive                              --
------------------------------------------------------------------------


-- INACTIVE FUNCTION DISPLAY
function M.inActiveLine()
  local file_name = func('expand', {'%F'})
  return space..file_name..space..buficon.get_file_icon()
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
