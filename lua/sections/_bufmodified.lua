local bufname = require 'sections._bufname'
local M = {}
function M.isBufferModified()
  local file = bufname.getBufferName()
  if file == ' startify ' then return '' end -- exception check
  local modifiedIndicator = [[%M ]]
  if modifiedIndicator == nil then return '' end --exception check
  return modifiedIndicator
end
return M

