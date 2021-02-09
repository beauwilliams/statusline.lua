# statusline.lua

![screencast](https://i.ibb.co/DM0pykL/op.gif)

## [BONUS] tabline.lua

![screenshot](https://i.ibb.co/Cw6Jzxh/Screen-Shot-2021-02-09-at-2-19-10-pm.png)

***A tidy statusline for neovim written in lua featuring***

🔋 Batteries Included. No configuration neccessary

🕴  Minimalist Mode Indicators

👁  Git Change [Signify]

🌴 Git Branch

❗️ Linter Status [Ale]

🔦 LSP Current Function [builtinlsp.current_function] --> Requires adding `lsp_status.on_attach(client)` on attach. 0 config workaround coming :)

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

    - Signify
    - Ale
    *I plan to shed some dependencies later once we get Async working for the Git Status & Git Branch (leaving this statusline with a total of 2 dependencies)*

## Planned Improvements 😼

- [ ] Completely move codebase to lua
- [ ] Async everything
- [ ] Shed Signify
- [x] Shed Fugitive
- [x] Shed Nvim-Webdev-Icons
- [ ] Theme Support

# This repo is in alpha stage and breaking changes may be made at any point
