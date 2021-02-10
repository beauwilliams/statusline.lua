local M = {}
local blank = ' '
function M.get_buffer_name() --> IF We are in a buffer such as terminal or startify with no filename just display the buffer 'type' i.e "startify"
  local filename = vim.fn.expand('%:t') -- api.nvim_call_function('expand', {'%f'})

  local filetype = vim.bo.ft --> Get vim filetype using nvim api
  if filename ~= '' then --> IF filetype empty i.e in a terminal buffer etc, return name of buffer (filetype)
    return filename..blank
  else
      if filetype ~= '' then
          return filetype..blank
      else
        return '' --> AFAIK buffers tested have types but just incase.
      end
  end
end
return M

