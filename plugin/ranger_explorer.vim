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
let g:loaded_netrwPlugin = 'disable'

let s:save_cpoptions = &cpoptions
set cpoptions&vim

command! RangerOpenCurrentFile
\    call ranger_explorer#open_current_file(<q-args>)

command! RangerOpenCurrentDir
\    call ranger_explorer#open_current_dir(<q-args>)

command! RangerOpenProjectRootDir
\    call ranger_explorer#open_project_root_dir(<q-args>)

augroup open_with_ranger
  autocmd!
  autocmd BufEnter * silent call ranger_explorer#open_with_edit(expand("<amatch>"))
augroup END


let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
