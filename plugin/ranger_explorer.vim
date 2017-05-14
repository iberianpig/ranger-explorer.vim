"=============================================================================
" File: ranger_explorer.vim
" Author: iberianpig
" Created: 2017-04-09
"=============================================================================

scriptencoding utf-8

if exists('g:loaded_ranger_explorer')
  finish
endif
let g:loaded_ranger_explorer = 1

let s:save_cpo = &cpo
set cpo&vim

command! RangerOpenCurrentDir
\    call ranger_explorer#open_current_dir()

command! RangerOpenProjectRootDir
\    call ranger_explorer#open_project_root_dir()

augroup open_with_ranger
  autocmd!
  let g:loaded_netrwPlugin = 'disable'
  autocmd BufEnter * silent call ranger_explorer#open_with_edit(expand("<amatch>"))
augroup END


let &cpo = s:save_cpo
unlet s:save_cpo