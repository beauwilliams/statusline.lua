# statusline.lua

![screencast](https://i.ibb.co/DM0pykL/op.gif)

## tabline.lua [BONUS]

![screenshot](https://i.ibb.co/zhqf9nK/Screen-Shot-2021-02-09-at-2-19-10-pm.png)

***A tidy statusline for neovim written in lua featuring***

🔋 Batteries Included. No configuration neccessary

🕴  Minimalist Mode Indicators

🔥 .4ms Startup Time

👁  Git Status [Signify]

🌴 Git Branch

❗️ Linter Status [Ale]

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


## Optional Dependencies

    - Signify [Git Status]
    - Ale [Linter]
    - LSP_Current_Func [require('lsp-status').on_attach(client)]

## Planned Improvements 😼

- [ ] Completely move codebase to lua
- [ ] Async everything
- [x] Shed Fugitive
- [x] Shed Nvim-Webdev-Icons
- [ ] Theme Support

# This repo is in alpha stage and breaking changes may be made at any point
