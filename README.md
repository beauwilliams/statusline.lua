# statusline.lua

![screencast](https://i.ibb.co/DM0pykL/op.gif)

A tidy statusline for neovim written in lua featuring
🔋 Batteries Included. No configuration neccessary
🕴  Minimalist Mode Indicators
👁  Git Change [Signify]
🌴 Git Branch [Fugitive]
❗️ Linter Status [Ale]
🔦 LSP Current Function [builtinlsp.current_function]
❓ File Modified Status
👌 Clean Ruler
⚙️  File Icons
🙌 Snipped File Paths
😻 Tabline Support
🚀 File Icon Support [Dev Icons]

## Installation
### [vim-plug](https://github.com/junegunn/vim-plug)
```vim
Plug 'beauwilliams/statusline.lua'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
```
### [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use {
  'beauwilliams/statusline.lua',
  requires = {'kyazdani42/nvim-web-devicons', opt = true}
}


## Dependencies

    - Signify
    - Ale
    - Fugitive
    - Dev Icons
*I plan to shed some dependencies later once we get Async working for the Git Status & Git Branch (leaving this statusline with a total of 2 dependencies)*

## Planned Improvements 😼

- [ ] Completely move codebase to lua
- [ ] Async everything
- [ ] Shed Signify & Fugitive Dependencies
- [ ] Theme Support

# This repo is in alpha stage and breaking changes may be made at any point
