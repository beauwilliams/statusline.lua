
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

-- TODO--> [beauwilliams] --> Refactor sections into their own files
local api = vim.api
local modes = require 'tables._modes'
local git_branch = require 'sections._git_branch'
local lsp = require 'sections._lsp'
local signify = require 'sections._signify'
local bufmod = require 'sections._bufmodified'
local bufname = require 'sections._bufname'
local buficon = require 'sections._buficon'
local editable = require 'sections._bufeditable'
local filesize = require 'sections._filesize'
local M = {}


-- Separators
local left_separator = ''
local right_separator = ''

-- Blank Between Components
local blank = ' '

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
local bg = '#504945'

-- Filename Color
local file_bg = purple
local file_fg = black_fg
--local file_gui = 'bold'
api.nvim_command('hi File guibg='..file_bg..' guifg='..file_fg)
api.nvim_command('hi FileSeparator guifg='..file_bg)

-- Working directory Color
local dir_bg = bg
local dir_fg = white_fg
--local dir_gui = 'bold'
api.nvim_command('hi Directory guibg='..dir_bg..' guifg='..dir_fg)
api.nvim_command('hi DirSeparator guifg='..dir_bg)

-- FileType Color
local filetype_bg = 'None'
local filetype_fg = purple
--local filetype_gui = 'bold'
api.nvim_command('hi Filetype guibg='..filetype_bg..' guifg='..filetype_fg)

-- row and column Color
local line_bg = 'None'
local line_fg = white_fg
local line_gui = 'regular'
api.nvim_command('hi Line guibg='..line_bg..' guifg='..line_fg)

--LSP Function Highlight Color
api.nvim_command('hi StatuslineLSPFunc guibg='..line_bg..' guifg='..green)

--SET TABLINE COLOURS
api.nvim_command('hi TabLineSel gui=Bold guibg=#8ec07c guifg=#292929')
api.nvim_command('hi TabLineSelSeparator gui=bold guifg=#8ec07c')
api.nvim_command('hi TabLine guibg=#504945 guifg=#b8b894 gui=None')
api.nvim_command('hi TabLineSeparator guifg=#504945')
api.nvim_command('hi TabLineFill guibg=None gui=None')

-- INACTIVE BUFFER Colours
local InactiveLine_bg = '#1c1c1c'
local InactiveLine_fg = white_fg
api.nvim_command('hi InActive guibg='..InactiveLine_bg..' guifg='..InactiveLine_fg)



-- Redraw different colors for different mode
local RedrawColors = function(mode)
  if mode == 'n' then
    api.nvim_command('hi Mode guibg='..green..' guifg='..black_fg..' gui=bold')
    api.nvim_command('hi ModeSeparator guifg='..green)
  end
  if mode == 'i' then
    api.nvim_command('hi Mode guibg='..blue..' guifg='..black_fg..' gui=bold')
    api.nvim_command('hi ModeSeparator guifg='..blue)
  end
  if mode == 'v' or mode == 'V' or mode == '^V' then
    api.nvim_command('hi Mode guibg='..purple..' guifg='..black_fg..' gui=bold')
    api.nvim_command('hi ModeSeparator guifg='..purple)
  end
  if mode == 'c' then
    api.nvim_command('hi Mode guibg='..yellow..' guifg='..black_fg..' gui=bold')
    api.nvim_command('hi ModeSeparator guifg='..yellow)
  end
  if mode == 't' then
    api.nvim_command('hi Mode guibg='..red..' guifg='..black_fg..' gui=bold')
    api.nvim_command('hi ModeSeparator guifg='..red)
  end
end
------------------------------------------------------------------------
--                              Statusline                            --
------------------------------------------------------------------------
function M.activeLine()
  local statusline = ""
  -- Component: Mode
  local mode = api.nvim_get_mode()['mode']
  RedrawColors(mode)
  statusline = statusline.."%#ModeSeparator#"..blank
  statusline = statusline.."%#ModeSeparator#"..left_separator.."%#Mode# "..modes.current_mode[mode].." %#ModeSeparator#"..right_separator
  -- Component: Filetype and icons
  statusline = statusline.."%#Line#"..bufname.get_buffer_name()
  statusline = statusline..buficon.get_file_icon()

  -- Component: errors and warnings -> requires ALE
  -- TODO--> [beauwilliams] --> IMPLEMENT A LUA VERSION OF BELOW VIMSCRIPT FUNCS
  statusline = statusline..vim.call('LinterStatus')
  -- TODO--> SUPPORT COC LATER, NEEDS TESTING WITH COC USERS FIRST
  -- statusline = statusline..M.cocStatus()

  -- Component: git commit stats -> REQUIRES SIGNIFY
  statusline = statusline..signify.signify()


  -- Component: git branch name -> requires FUGITIVE
  statusline = statusline..git_branch.branch()

  -- Alignment to left
  statusline = statusline.."%="

  -- Component: LSP CURRENT FUCTION --> Requires LSP
  statusline = statusline.."%#StatuslineLSPFunc# "..lsp.lsp_current_function()

  -- RIGHT SIDE INFO
  -- Component: Modified, Read-Only, Filesize, Row/Col
  statusline = statusline.."%#Line#"..bufmod.is_buffer_modified()
  statusline = statusline..editable.editable()..filesize.get_file_size()..[[ʟ %l/%L c %c]]..blank
  api.nvim_command('set noruler') --disable line numbers in bottom right for our custom indicator as above

  return statusline
end


------------------------------------------------------------------------
--                              Inactive                              --
------------------------------------------------------------------------


-- INACTIVE FUNCTION DISPLAY
function M.inActiveLine()
  local file_name = api.nvim_call_function('expand', {'%F'})
  return blank..file_name..blank..buficon.get_file_icon()
end


return M
