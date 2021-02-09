local M = {}
function M.lspCurrentFunction()
  local lsp_function = vim.b.lsp_current_function
  if lsp_function == nil then return '' end
  return lsp_function
end
return M

