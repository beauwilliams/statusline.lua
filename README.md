# statusline.lua

![screencast](https://i.ibb.co/DM0pykL/op.gif)

## tabline.lua [BONUS]

![screenshot](https://i.ibb.co/zhqf9nK/Screen-Shot-2021-02-09-at-2-19-10-pm.png)

***A tidy statusline for neovim written in lua featuring***

🔋 Batteries Included. No configuration needed.

🕴  Minimalist Mode Indicators

🔥 0.4ms Startup Time

👁  Git Status [Signify]

🌴 Git Branch

❗️ Diagnostics Status [Ale & Native Nvim LSP] --> Native LSP set as default

🔦 LSP Current Function [builtinlsp.current_function] --> Requires `require('lsp-status').on_attach(client)`

❓ File Modified Status

👌 Clean Ruler

⚙️  File Icon Support [Nerd Font]

🙌 Snipped File Paths

😻 Tabline Support

🎨 Smooth colours inspired by gruvbox

🚀 More to come!

## Installation
### [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'beauwilliams/statusline.lua'
```
### [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use 'beauwilliams/statusline.lua'
```

# Configuration
**Disable Tabline**
```lua
local statusline = require('statusline')
statusline.tabline = false
```

**Enable ALE Diagnostics Display**
```lua
-- NOTE: Nvim Native LSP is displayed default
-- I personally prefer ALE, with nathunsmitty/nvim-ale-diagnostic piping LSP diags
-- With ALE you can get errors displayed without explicitly needing an LSP server
local statusline = require('statusline')
statusline.lsp_diagnostics = false
statusline.ale_diagnostics = true
```


## Optional Dependencies

    - Signify [Git Status]
    - Ale [Linter]
    - LSP_Current_Func [require('lsp-status').on_attach(client)]

## Planned Improvements 😼

- [ ] Completely move codebase to lua
- [ ] Async everything
- [x] Shed Fugitive
- [x] Shed Nvim-Webdev-Icons
- [x] Support Native LSP
- [ ] Theme Support

# Credits

[lualine](https://github.com/hoob3rt/lualine.nvim)
[galaxyline](https://github.com/glepnir/galaxyline.nvim/tree/main/lua/galaxyline)
[neoline](https://github.com/adelarsq/neoline.vim/tree/master/lua)


# This repo is in alpha stage and breaking changes may be made at any point
