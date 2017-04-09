"=============================================================================
" File: ranger_explorer.vim
" Author: iberianpig
" Created: 2017-04-09
"=============================================================================

scriptencoding utf-8

if !exists('g:loaded_ranger_explorer')
    finish
endif
let g:loaded_ranger_explorer = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:project_root_dir()
  let current_dir = expand('%:p:h')
  let relative_git_dir = finddir('.git', current_dir . ';') 
  let relative_root_dir = fnamemodify(relative_git_dir, ':h')
  let root_dir = current_dir . '/' . relative_root_dir
  if !isdirectory(root_dir)
    return current_dir
  endif
  return root_dir
endfunction

function! ranger_explorer#open(path)
  if !executable('ranger')
    echomsg 'You need install ranger.'
    return
  endif
  exec 'silent !ranger --choosefile=/tmp/vim_ranger_current_file ' . a:path
  if filereadable('/tmp/vim_ranger_current_file')
    exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
    call system('rm /tmp/vim_ranger_current_file')
  endif
  redraw!
endfunction

function! ranger_explorer#open_project_root_dir() abort
  let root_dir = s:project_root_dir()
  :call ranger_explorer#open(root_dir)
endfunction

function! ranger_explorer#open_current_dir() abort
  let current_dir = expand('%:p:h')
  :call ranger_explorer#open(current_dir)
endfunction

function! ranger_explorer#open_with_edit(path) abort
  if !isdirectory(a:path)
    return
  endif
  bw!
  :call ranger_explorer#open(a:path)
  :filetype detect
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
