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

let g:ranger_explorer_keymap_edit    = '<C-o>'
let g:ranger_explorer_keymap_tabedit = '<C-t>'
let g:ranger_explorer_keymap_split   = '<C-s>'
let g:ranger_explorer_keymap_vsplit  = '<C-v>'

let s:kill_ranger = expand('<sfile>:p:h:h') . '/script/kill_parent_ranger.sh '

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
  let s:cmd_file  = tempname()
  let s:path_file = tempname()

  let edit    = 'map ' . g:ranger_explorer_keymap_edit    . ' shell -c ' . s:kill_ranger . 'edit \%d/\%s' . ' ' . s:cmd_file. ' ' . s:path_file 
  let tabedit = 'map ' . g:ranger_explorer_keymap_tabedit . ' shell -c ' . s:kill_ranger . 'tabedit \%d/\%s' . ' ' . s:cmd_file. ' ' . s:path_file 
  let split   = 'map ' . g:ranger_explorer_keymap_split   . ' shell -c ' . s:kill_ranger . 'split \%d/\%s' . ' ' . s:cmd_file. ' ' . s:path_file 
  let vsplit  = 'map ' . g:ranger_explorer_keymap_vsplit  . ' shell -c ' . s:kill_ranger . 'vsplit \%d/\%s' . ' ' . s:cmd_file. ' ' . s:path_file 

  exec 'silent !ranger --choosefile=' . s:path_file . ' ' . a:path 
        \ . ' --cmd="' . edit . '"'
        \ . ' --cmd="' . tabedit . '"'
        \ . ' --cmd="' . split . '"'
        \ . ' --cmd="' . vsplit . '"'

  if !filereadable(s:path_file)
    redraw!
    return
  endif

  let edit_path = system('cat ' . s:path_file . " | tr -d '\n'")
  call system('rm ' . s:path_file)

  if filereadable(s:cmd_file)
    let edit_cmd = system('cat ' . s:cmd_file . " | tr -d '\n'")
    call system('rm ' . s:cmd_file)
  else
    let edit_cmd = 'edit'
  endif

  exec edit_cmd . ' ' . edit_path

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
