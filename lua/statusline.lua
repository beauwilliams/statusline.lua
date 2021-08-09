
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

local tabline = require'modules.tabline'
local statusline = require'modules.statusline'
local M = {}
M.tabline = true -- Default to true
M.ale_diagnostics = false -- Disable Ale by default [I personally use ale as it means we get errors without lsp servers needing to be installed]
M.lsp_diagnostics = true -- Enable Nvim native LSP as default


------------------------------------------------------------------------
--                              Statusline                            --
------------------------------------------------------------------------
function M.activeLine()
  vim.wo.statusline=statusline.activeLine()
end

function M.simpleLine()
  vim.wo.statusline=statusline.simpleLine()
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
    if M.tabline == true then
        vim.o.tabline = tabline.init()
    end
end

return M
