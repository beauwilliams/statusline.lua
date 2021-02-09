local bufname = require 'sections._bufname'
local M = {}
function M.is_buffer_modified()
  local file = bufname.get_buffer_name()
  if file == ' startify ' then return '' end -- exception check
  local modifiedIndicator = [[%M ]]
  if modifiedIndicator == nil then return '' end --exception check
  return modifiedIndicator
end
return M

