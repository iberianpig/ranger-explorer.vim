# ranger-explorer.vim

Vim/Neovim plugin to use [Ranger](https://ranger.github.io/) as a file explorer.

![ranger-explorer](https://i.gyazo.com/fb4c28ca7bfc74559b3ba08b02da2c95.gif)

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Commands](#commands)
- [Configuration](#configuration)
- [Keymaps](#keymaps)
- [How It Works](#how-it-works)
- [FAQ](#faq)
- [License](#license)

## Features

- **Seamless Integration** - Switch between Vim/Neovim and Ranger effortlessly
- **Multiple Open Methods** - Open files via `edit`, `tabedit`, `split`, or `vsplit`
- **Flexible Navigation** - Open from current file, current directory, or project root
- **Custom Arguments** - Pass additional arguments to Ranger commands
- **Directory Auto-expand** - Automatically opens Ranger when editing a directory (replaces netrw)
- **Vim & Neovim Support** - Works with both Vim and Neovim

## Requirements

- [Ranger](https://ranger.github.io/) - A VIM-inspired file manager for the console
- [bclose.vim](https://github.com/rbgrouleff/bclose.vim) - **Required for Neovim only**

> **Note:** When using this plugin, netrw's directory browsing is automatically disabled (`let g:loaded_netrwPlugin = 1`).

## Installation

### lazy.nvim (recommended)

```lua
{
  'iberianpig/ranger-explorer.vim',
  dependencies = { 'rbgrouleff/bclose.vim' },
}
```

### packer.nvim

```lua
use {
  'iberianpig/ranger-explorer.vim',
  requires = { 'rbgrouleff/bclose.vim' },
}
```

### vim-plug

```vim
" For Neovim
Plug 'rbgrouleff/bclose.vim'
Plug 'iberianpig/ranger-explorer.vim'

" For Vim (bclose.vim is not required)
Plug 'iberianpig/ranger-explorer.vim'
```

### dein.vim

```vim
call dein#add('rbgrouleff/bclose.vim')  " Required for Neovim
call dein#add('iberianpig/ranger-explorer.vim')
```

## Commands

| Command | Description |
|---------|-------------|
| `:Ranger [path]` | Open Ranger at the specified path |
| `:RangerOpenCurrentFile [args]` | Open Ranger at current file's location |
| `:RangerOpenCurrentDir [args]` | Open Ranger in current working directory |
| `:RangerOpenProjectRootDir [args]` | Open Ranger at project root directory |

### Passing Custom Arguments

You can pass additional arguments to Ranger:

```vim
" Open Ranger with hidden files shown
:RangerOpenCurrentDir --show-hidden

" Open Ranger with a specific command
:RangerOpenCurrentFile --cmd='set viewmode multipane'
```

## Configuration

### Keymap Options

Customize the keymaps used within Ranger:

| Variable | Default | Description |
|----------|---------|-------------|
| `g:ranger_explorer_keymap_edit` | `<C-o>` | Open file in current tab |
| `g:ranger_explorer_keymap_tabedit` | `<C-t>` | Open file in new tab |
| `g:ranger_explorer_keymap_split` | `<C-s>` | Open file in horizontal split |
| `g:ranger_explorer_keymap_vsplit` | `<C-v>` | Open file in vertical split |

### Example Configuration

```vim
" In your .vimrc or init.vim
let g:ranger_explorer_keymap_edit    = '<C-o>'
let g:ranger_explorer_keymap_tabedit = '<C-t>'
let g:ranger_explorer_keymap_split   = '<C-s>'
let g:ranger_explorer_keymap_vsplit  = '<C-v>'
```

For lazy.nvim:

```lua
{
  'iberianpig/ranger-explorer.vim',
  dependencies = { 'rbgrouleff/bclose.vim' },
  init = function()
    vim.g.ranger_explorer_keymap_edit    = '<C-o>'
    vim.g.ranger_explorer_keymap_tabedit = '<C-t>'
    vim.g.ranger_explorer_keymap_split   = '<C-s>'
    vim.g.ranger_explorer_keymap_vsplit  = '<C-v>'
  end,
}
```

## Keymaps

### Keymaps in Ranger

When Ranger is launched from ranger-explorer, the following keymaps are available:

| Key | Action |
|-----|--------|
| `<Ctrl-o>` | Open file in existing tab |
| `<Ctrl-t>` | Open file in new tab |
| `<Ctrl-v>` | Open file with vertical split |
| `<Ctrl-s>` | Open file with horizontal split |

### Recommended Vim Keymaps

Add these to your `~/.vimrc` or `~/.config/nvim/init.vim`:

```vim
nnoremap <silent><Leader>n :RangerOpenCurrentFile<CR>
nnoremap <silent><Leader>c :RangerOpenCurrentDir<CR>
nnoremap <silent><Leader>f :RangerOpenProjectRootDir<CR>
```

For lazy.nvim:

```lua
{
  'iberianpig/ranger-explorer.vim',
  dependencies = { 'rbgrouleff/bclose.vim' },
  keys = {
    { '<Leader>n', '<Cmd>RangerOpenCurrentFile<CR>',       desc = 'Ranger: Current file' },
    { '<Leader>c', '<Cmd>RangerOpenCurrentDir<CR>',        desc = 'Ranger: Current dir' },
    { '<Leader>f', '<Cmd>RangerOpenProjectRootDir<CR>',    desc = 'Ranger: Project root' },
  },
}
```

## How It Works

### Project Root Detection

`:RangerOpenProjectRootDir` finds the project root by searching upward for a `.git` directory. If no `.git` is found, it falls back to the current working directory.

### File Selection Flow

1. Launch Ranger from Vim/Neovim using one of the commands
2. Navigate and select files in Ranger
3. Use `<C-o>`, `<C-t>`, `<C-v>`, or `<C-s>` to open the selected file
4. The file opens in Vim/Neovim in the same process (not as a child of Ranger)

## FAQ

### How do I disable the automatic directory expansion?

To prevent Ranger from automatically opening when you edit a directory:

```vim
let g:loaded_netrwPlugin = 0
```

Or use another file explorer plugin that handles directory buffers.

### Can I use this with other file explorers?

Yes, ranger-explorer.vim can coexist with other file explorers like NERDTree or nvim-tree. However, since it disables netrw by default, directory buffers will be handled by Ranger.

### Why is bclose.vim required for Neovim?

Neovim's terminal buffer handling differs from Vim's. The bclose.vim plugin provides a reliable way to close the Ranger terminal buffer without side effects.

## License

MIT License

Copyright (c) 2017 Kohei Yamada

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
