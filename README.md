[![GitHub stars](https://img.shields.io/github/stars/beauwilliams/statusline.lua.svg?style=social&label=Star&maxAge=2592000)](https://GitHub.com/beauwilliams/statusline.lua/stargazers/)
[![Requires](https://img.shields.io/badge/requires-nvim%200.5%2B-9cf?logo=neovim)](https://neovim.io//)
[![GitHub contributors](https://img.shields.io/github/contributors/beauwilliams/statusline.lua.svg)](https://GitHub.com/beauwilliams/statusline.lua/graphs/contributors/)
[![GitHub issues](https://img.shields.io/github/issues/beauwilliams/statusline.lua.svg)](https://GitHub.com/beauwilliams/statusline.lua/issues/)
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/beauwilliams/statusline.lua.svg)](https://GitHub.com/beauwilliams/statusline.lua/issues?q=is%3Aissue+is%3Aclosed)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)


# Statusline.lua
![screenshot](https://i.imgur.com/QocSv7V.png)

# Statusline
![screencast](https://i.ibb.co/wgTJ58D/ezgif-4-b462544889e2.gif)

# Tabline [BONUS]
![screenshot](https://i.ibb.co/zhqf9nK/Screen-Shot-2021-02-09-at-2-19-10-pm.png)

# Light Theme Compatible
![screenshot](https://i.ibb.co/VmQ6CMy/Screen-Shot-2022-03-20-at-1-10-40-pm.png)


***A tidy statusline for neovim written in lua featuring***

🔋 Batteries Included. No configuration needed.

🕴  Minimalist Mode Indicators

🔥 0.4ms Startup Time

👁  Git Status [Signify]

🌴 Git Branch

❗️ Diagnostics Status [Ale & Native Nvim LSP] --> Native LSP set as default

🔦 LSP Current Function [builtinlsp.current_function] --> Requires `require('lsp-status').on_attach(client)`

💡 LSP Code Action Indicator [textDocument/codeAction] --> Requires `kosayoda/nvim-lightbulb/`

💯 LSP Progress Messages ⠼ [vim.lsp.util.get_progress_messages]

❓ File Modified Status

👌 Clean Ruler

⚙️  File Icon Support [Nerd Font]

🙌 Snipped File Paths

😻 Tabline Support

🎨 Smooth colours inspired by *gruvbox*

🚀 More to come!

# Installation
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

**Enable Global Statusline (version 0.7+)**
```lua
-- This setting will mean that you have one single statusline drawn accross the entire display
lua vim.o.laststatus=3
```

## Optional Dependencies

    - Signify [Git Status]
    - Ale [Diagnostics] --> I recommend ALE with nathunsmitty/nvim-ale-diagnostic
    - Native LSP [Current Function] --> require('lsp-status').on_attach(client)
    - Native LSP [Diagnostics] --> Must have a relevant language server to provide diagnostics
    - Native LSP [Progress %] --> Must have a relevant language server to provide progress messages
    - Native LSP [Code Actions] --> Requires kosayoda/nvim-lightbulb/

## Planned Improvements 😼

- [ ] Completely move codebase to lua
- [ ] Async everything
- [x] Shed Fugitive
- [x] Shed Nvim-Webdev-Icons
- [x] Support Native LSP
- [ ] Theme Support

# Developers Only

**Contributing**

Please before submitting a PR install stylua [here](https://github.com/JohnnyMorganz/StyLua)

And run `stylua .` from your shell in the root folder of `focus.nvim`

This will format the code according to the guidlines set in `stylua.toml`


# Credits

[lualine](https://github.com/hoob3rt/lualine.nvim)
[galaxyline](https://github.com/glepnir/galaxyline.nvim/tree/main/lua/galaxyline)
[neoline](https://github.com/adelarsq/neoline.vim/tree/master/lua)
