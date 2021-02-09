local M = {}
local blank = ' '
function M.lspCurrentFunction()
  local lsp_function = vim.b.lsp_current_function
  if lsp_function == nil then return '' end
  return lsp_function..blank
end
return M

