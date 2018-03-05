## ranger-explorer.vim
Vim plugin to use [ranger](http://ranger.nongnu.org/) as a file explorer. Seamless switching between vim and ranger.

[![https://gyazo.com/cf9dfdbf4fd45e0e88d54c2f9fe501cb](https://i.gyazo.com/cf9dfdbf4fd45e0e88d54c2f9fe501cb.gif)](https://gyazo.com/cf9dfdbf4fd45e0e88d54c2f9fe501cb)

## Requirement

* ranger(http://ranger.nongnu.org/)

## installation

```vim
NeoBundle     'iberianpig/ranger-explorer.vim'
```

### Usage

```vim
nnoremap <silent><Leader>c :RangerOpenCurrentDir<CR>
nnoremap <silent><Leader>f :RangerOpenProjectRootDir<CR>
```
