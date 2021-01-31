------------------------------------------------------------------------
--                             Variables                              --
------------------------------------------------------------------------

local api = vim.api
local icons = require 'devicon'
local Utils = require 'beauwilliams.utils'
local M = {}

-- Different colors for mode
local purple = '#BF616A' --#B48EAD
local blue = '#83a598' --#81A1C1
local yellow = '#fabd2f' --#EBCB8B
local green = '#8ec07c' --#A3BE8C
local red = '#fb4934' --#BF616A

-- fg and bg
local white_fg = '#b8b894'
local black_fg = '#282c34'
local bg = '#4d4d4d'

-- Separators
local left_separator = ''
local right_separator = ''

-- Blank Between Components
local blank = ' '

local warningIcon = ''
local exclamationIcon = ''
local plusIcon = ''
local tildeIcon = 'ﰣ'
local minusIcon = ''
local errorIcon =''

------------------------------------------------------------------------
--                             Colours                                --
------------------------------------------------------------------------
-- INIT

--function! SetStatusline() abort
    --luafile ~/.config/nvim/lua/beauwilliams/statusline.lua
--endfunction

 --"Change statusline automatically
--augroup Statusline
  --autocmd!
  --autocmd WinEnter,BufEnter * :call SetStatusline()
  --autocmd WinLeave,BufLeave * setlocal statusline=
--augroup END


  --autocmd WinEnter,BufEnter * :call SetStatusline()
  --autocmd WinLeave,BufLeave * setlocal statusline=


-- Mode Prompt Table
local current_mode = setmetatable({
      ['n'] = 'N',
      ['no'] = 'N·Operator Pending',
      ['v'] = 'VISUAL',
      ['V'] = 'V·Line',
      ['^V'] = 'V·Block',
      ['s'] = 'Select',
      ['S'] = 'S·Line',
      ['^S'] = 'S·Block',
      ['i'] = 'I',
      ['ic'] = 'INSERT',
      ['ix'] = 'INSERT',
      ['R'] = 'Replace',
      ['Rv'] = 'V·Replace',
      ['c'] = 'C',
      ['cv'] = 'Vim Ex',
      ['ce'] = 'Ex',
      ['r'] = 'Prompt',
      ['rm'] = 'More',
      ['r?'] = 'Confirm',
      ['!'] = 'Shell',
      ['t'] = 'T'
    }, {
      -- fix weird issues
      __index = function(_, _)
        return 'V·Block'
      end
    }
)

 --Obsession Color
--local obsession_fg = purple
--local obsession_gui = 'bold'
--api.nvim_command('hi Obsession guifg='..obsession_fg..' gui='..obsession_gui)

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
--                              Functions                             --
------------------------------------------------------------------------
local TrimmedDirectory = function(dir)
  local home = os.getenv("HOME")
  local _, index = string.find(dir, home, 1)
  if index ~= nil and index ~= string.len(dir) then
    -- TODO Trimmed Home Directory
    return string.gsub(dir, home, '~')
  end
  return dir
end

local function getFileIcon()
  local file_name = api.nvim_buf_get_name(current_buf)
  if string.find(file_name, 'term://') ~= nil then
    icon = ' '..api.nvim_call_function('fnamemodify', {file_name, ":p:t"})
  end
  file_name = api.nvim_call_function('fnamemodify', {file_name, ":p:t"})
  if file_name == '' then
    icon = ''
    return icon
  end
  local icon = icons.deviconTable[file_name]
  if icon ~= nil then
    return icon..blank
  else
    return ''
  end
end

--local function getBranchBubbly()
--local data = vim.b.git_branch
   --if data ~= '' then
     --return data
   --end
 --end
 --print(getBranchBubbly())



local function getGitBranch() --> NOTE: THIS FN HAS AN ASYNC ISSUE AND NEEDS TO BE DEALT WITH LATER
local branch = vim.fn.systemlist('cd ' .. vim.fn.expand('%:p:h:S') .. ' 2>/dev/null && git status --porcelain -b 2>/dev/null')[1]
--local branch = vim.fn.systemlist('cd ' .. vim.fn.expand('%:p:h:S') .. ' 2>/dev/null && git rev-parse --abbrev-ref HEAD')[1] --> Same async issue
--local data = vim.b.git_branch
      if not branch or #branch == 0 then
         return ''
      end
      branch = branch:gsub([[^## No commits yet on (%w+)$]], '%1')
      branch = branch:gsub([[^##%s+(%w+).*$]], '%1')
--sleep(1)
--os.execute("sleep 2") --> DOES NOT WORK ONLY HAD BRIEF CRACK AT THIS RETURN LATER

return branch
end

local function getBufferName() --> IF We are in a buffer such as terminal or startify with no filename just display the buffer 'type' i.e "startify"
  local filename = api.nvim_call_function('expand', {'%f'})
  local filetype = vim.bo.ft --> Get vim filetype using nvim api
  if filename ~= '' then --> IF filetype empty i.e in a terminal buffer etc, return name of buffer (filetype)
    return blank..filename..blank
  else
      if filetype ~= '' then
          return blank..filetype..blank
      else
        return '' --> AFAIK buffers tested have types but just incase.
      end
  end
end

local function isModified() --> TODO: Remove the - icon when opening startify
  local modifiedIndicator = [[%M ]]
  --local modifiedIndicator = vim.fn.expand('%M') --> DOES NOT WORK RETS FILENAME
  --if modifiedIndicator ~= ''  or '-' then
    --print(modifiedIndicator)
    --return ''
  --end
  return modifiedIndicator
end


-- neoclide/coc.nvim
local function cocStatus()
  local cocstatus = ''
  -- local exists = Utils.Exists('coc#status')
  if vim.fn.exists('*coc#status') == 0 then return '' end
  -- if exists == 0 then
    cocstatus = Utils.Call('coc#status', {})
  -- end
  return cocstatus
end

local function signify()
   if vim.fn.exists('*sy#repo#get_stats') == 0 then return '' end
   local added, modified, removed = unpack(vim.fn['sy#repo#get_stats']())
   if added == -1 then return '' end
   local symbols = {
     '+',
     '-',
     '~',
   }
   local result = {}
   local data = {
    added,
    removed,
    modified,
   }
   for range=1,3 do
     if data[range] ~= nil and data[range] > 0
       then table.insert(result,symbols[range]..data[range]..blank)
     end
   end

   if result[1] ~= nil then
       return table.concat(result, '')
   else
       return ''
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
  statusline = statusline.."%#ModeSeparator#"..left_separator.."%#Mode# "..current_mode[mode].." %#ModeSeparator#"..right_separator
  -- Component: Filetype and icons
  statusline = statusline.."%#Line#"..getBufferName()
  statusline = statusline..getFileIcon()
  statusline = statusline..cocStatus()

  -- Component: errors and warnings -> requires ALE
  statusline = statusline..vim.call('LinterStatus')

  -- Component: git commit stats -> REQUIRES SIGNIFY
  statusline = statusline..signify()
  -- statusline = statusline..vim.call('GitStats')
  -- Component: git branch name -> requires FUGITIVE
  statusline = statusline..vim.call('GetGitBranchName')
  --statusline = statusline..getGitBranch()
  --statusline = statusline..co

  --LEAVING FOR REF DEC 2020
  --statusline = statusline..[[%{MyStatusline()}]]
  --local lintStatus = api.nvim_call_function('Test')
  --statusline = statusline..blank
  --statusline = statusline..getGitBranch() -- HAS AN ASYNC ISSUE
  --SEE HERE https://vi.stackexchange.com/questions/27003/how-to-start-an-async-function-in-vim-8

  -- Alignment to left
  statusline = statusline.."%="

  local lsp_function = vim.b.lsp_current_function
  if lsp_function ~= nil then
    statusline = statusline.."%#StatuslineLSPFunc# "..lsp_function..blank
  end

    --statusline = statusline..vim.call('StatusLSPNative')
    --statusline = statusline..vim.b.lsp



    -- RIGHT SIDE INFO
    statusline = statusline.."%#Line#"..vim.call('FileIsModified') --."%#Line#" ..[[%M]].
    statusline = statusline..vim.call('ReadOnly')..vim.call('FileSize')..[[ʟ %l/%L c %c]]..blank
    --statusline = statusline..blank
  --local filetype = api.nvim_buf_get_option(0, 'filetype')
  --statusline = statusline.."%#Filetype#  Filetype: "..filetype
  --statusline = statusline..blank

  -- Component: FileType
  -- Component: row and col
  api.nvim_command('set noruler') --disable line numbers in bottom right
--[[
  local line = api.nvim_call_function('line', {"."})
  local col = vim.fn.col('.')
  while string.len(line) < 3 do
    line = line..blank
  end
  while string.len(col) < 3 do
    col = col..blank
  end
  statusline = statusline.."%#Line# ℓ "..line.." 𝚌 "..col
--]]
  return statusline
end





------------------------------------------------------------------------
--                              Inactive                              --
------------------------------------------------------------------------



-- INACTIVE BUFFER Colours
local InactiveLine_bg = '#1c1c1c'
local InactiveLine_fg = white_fg
api.nvim_command('hi InActive guibg='..InactiveLine_bg..' guifg='..InactiveLine_fg)


-- INACTIVE FUNCTION DISPLAY
function M.inActiveLine()
  local file_name = api.nvim_call_function('expand', {'%F'})
  return blank..file_name..getFileIcon()

end


------------------------------------------------------------------------
--                              TabLine                               --
------------------------------------------------------------------------

local getTabLabel = function(n)
  local current_win = api.nvim_tabpage_get_win(n)
  local current_buf = api.nvim_win_get_buf(current_win)
  local file_name = api.nvim_buf_get_name(current_buf)
  if string.find(file_name, 'term://') ~= nil then
    return ' '..api.nvim_call_function('fnamemodify', {file_name, ":p:t"})
  end
  file_name = api.nvim_call_function('fnamemodify', {file_name, ":p:t"})
  if file_name == '' then
    return "No Name"
  end
  local icon = icons.deviconTable[file_name]
  if icon ~= nil then
    return icon..blank..file_name
  end
  return file_name
end

api.nvim_command('hi TabLineSel gui=Bold guibg=#81A1C1 guifg=#292929')
api.nvim_command('hi TabLineSelSeparator gui=bold guifg=#81A1C1')
api.nvim_command('hi TabLine guibg=#4d4d4d guifg=#c7c7c7 gui=None')
api.nvim_command('hi TabLineSeparator guifg=#4d4d4d')
api.nvim_command('hi TabLineFill guibg=None gui=None')




function M.TabLine()
  local tabline = ''
  local tab_list = api.nvim_list_tabpages()
  local current_tab = api.nvim_get_current_tabpage()
  for _, val in ipairs(tab_list) do
    local file_name = getTabLabel(val)
    if val == current_tab then
      tabline = tabline.."%#TabLineSelSeparator# "..left_separator
      tabline = tabline.."%#TabLineSel# "..file_name
      tabline = tabline.." %#TabLineSelSeparator#"..right_separator
    else
      tabline = tabline.."%#TabLineSeparator# "..left_separator
      tabline = tabline.."%#TabLine# "..file_name
      tabline = tabline.." %#TabLineSeparator#"..right_separator
    end
  end
  tabline = tabline.."%="
  -- Component: Working Directory
  local dir = api.nvim_call_function('getcwd', {})
  tabline = tabline.."%#DirSeparator#"..left_separator.."%#Directory# "..TrimmedDirectory(dir).." %#DirSeparator#"..right_separator
  tabline = tabline..blank
  return tabline
end
return M


-- SET THE STATUS LINE
--local wo = vim.wo
--wo.statusline = '%!luaeval("activeLine()")'
--api.nvim_command('autocmd BufEnter * :call SetStatusline()')
--api.nvim_command('autocmd WinEnter * :call SetStatusline()')
--api.nvim_command('autocmd BufLeave * :setlocal statusline=')
--api.nvim_command('autocmd WinLeave * :setlocal statusline=')
