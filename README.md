## ranger-explorer.vim
Vim plugin to use [ranger](http://ranger.nongnu.org/) as a file explorer. Seamless switching between vim and ranger.

![ranger-explorer](https://i.gyazo.com/fb4c28ca7bfc74559b3ba08b02da2c95.gif)

## Requirement

* ranger(http://ranger.nongnu.org/)

## installation

```vim
"NeoBundle
NeoBundle 'iberianpig/ranger-explorer.vim'

"vim-plug
Plug 'iberianpig/ranger-explorer.vim'
```

## Usage

### Available Command

#### Keymap on Ranger

Following commands are available on ranger launched from ranger-explorer

```
<Ctrl-o>: edit on existing tab
<Ctrl-t>: edit on new tab
<Ctrl-v>: edit with vsplit window
<Ctrl-s>: edit with split window
```

##### Customize Keymap on Ranger

Following keymap is defined as defaut
```vim
let g:ranger_explorer_keymap_edit    = '<C-o>'
let g:ranger_explorer_keymap_tabedit = '<C-t>'
let g:ranger_explorer_keymap_split   = '<C-s>'
let g:ranger_explorer_keymap_vsplit  = '<C-v>'
```

#### Keymap on Vim

Add following keymap to `~/.vimrc`
```vim
nnoremap <silent><Leader>c :RangerOpenCurrentDir<CR>
nnoremap <silent><Leader>f :RangerOpenProjectRootDir<CR>
```
