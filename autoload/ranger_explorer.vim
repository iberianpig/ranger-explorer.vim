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
  let root_dir = fnamemodify(relative_git_dir, ':h')
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
  let tempfile = tempname()
  exec 'silent !ranger --choosefile=' . tempfile . ' ' . a:path
  if filereadable(tempfile)
    exec 'edit ' . system('cat ' . tempfile)
    call system('rm ' . tempfile)
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
