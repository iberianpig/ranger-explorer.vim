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

let s:save_cpo = &cpoptions
set cpoptions&vim

" Public

function! ranger_explorer#open(path)
  if !executable('ranger')
    echoerr 'You need install ranger.'
    return
  endif

  if isdirectory(a:path)
    let command = 'ranger --choosefile=' . s:path_file . ' ' . a:path
          \ . ' --cmd="' . s:edit    . '"'
          \ . ' --cmd="' . s:tabedit . '"'
          \ . ' --cmd="' . s:split   . '"'
          \ . ' --cmd="' . s:vsplit  . '"'
  else
    let command = 'ranger --choosefile=' . s:path_file
          \ . ' --selectfile="' . a:path . '"'
          \ . ' --cmd="' . s:edit    . '"'
          \ . ' --cmd="' . s:tabedit . '"'
          \ . ' --cmd="' . s:split   . '"'
          \ . ' --cmd="' . s:vsplit  . '"'
  endif

  if has('nvim')
    let rangerCallback = { 'name': 'ranger' }
    function! rangerCallback.on_exit(job_id, code, event)
      " NOTE: Delete terminal's buffer left by killing ranger process
      silent! Bclose!
      try
        call s:open_file()
      endtry
    endfunction
    enew
    call termopen(command, rangerCallback)
    startinsert
  else
    exec 'silent !' . command
    call s:open_file()
  endif

endfunction

function! ranger_explorer#open_project_root_dir() abort
  let root_dir = s:project_root_dir()
  :call ranger_explorer#open(root_dir)
endfunction

function! ranger_explorer#open_current_dir() abort
  let current_dir = expand('%:p:h')
  :call ranger_explorer#open(current_dir)
endfunction

function! ranger_explorer#open_current_file() abort
  let current_file = expand('%')
  :call ranger_explorer#open(current_file)
endfunction

function! ranger_explorer#open_with_edit(path) abort
  if !isdirectory(a:path)
    return
  endif
  bw!
  :call ranger_explorer#open(a:path)
  :filetype detect
endfunction

" Private

function! s:initialize() abort
  let s:kill_ranger    = s:plugin_root . '/script/kill_parent_ranger.sh '
  let s:cmd_file       = tempname()
  let s:path_file      = tempname()

  let s:keymap_edit    = get(g:, 'ranger_explorer_keymap_edit',    '<C-o>')
  let s:keymap_tabedit = get(g:, 'ranger_explorer_keymap_tabedit', '<C-t>')
  let s:keymap_split   = get(g:, 'ranger_explorer_keymap_split',   '<C-s>')
  let s:keymap_vsplit  = get(g:, 'ranger_explorer_keymap_vsplit',  '<C-v>')

  " edit_cmd
  " NOTE: nvim can't recognized (%,# escapes)
  let edit_path= has('nvim') ? '%d/%s' : '\%d/\%s'

  let s:edit           = 'map ' . s:keymap_edit    . ' shell -c ' . s:kill_ranger . 'edit '    . edit_path    . ' ' . s:cmd_file. ' ' . s:path_file
  let s:tabedit        = 'map ' . s:keymap_tabedit . ' shell -c ' . s:kill_ranger . 'tabedit ' . edit_path . ' ' . s:cmd_file. ' ' . s:path_file
  let s:split          = 'map ' . s:keymap_split   . ' shell -c ' . s:kill_ranger . 'split '   . edit_path   . ' ' . s:cmd_file. ' ' . s:path_file
  let s:vsplit         = 'map ' . s:keymap_vsplit  . ' shell -c ' . s:kill_ranger . 'vsplit '  . edit_path  . ' ' . s:cmd_file. ' ' . s:path_file
endfunction

function! s:project_root_dir()
  let current_dir      = expand('%:p:h')
  let relative_git_dir = finddir('.git', current_dir . ';')
  let root_dir         = fnamemodify(relative_git_dir, ':h')
  if !isdirectory(root_dir)
    return current_dir
  endif
  return root_dir
endfunction

function! s:open_file() abort
  if filereadable(s:cmd_file)
    for c in readfile(s:cmd_file)
      let cmd = c
    endfor
    call delete(s:cmd_file)
  else
    let cmd = 'edit'
  endif

  if filereadable(s:path_file)
    for path in readfile(s:path_file)
      exec cmd . path
    endfor
    call delete(s:path_file)
  endif
  redraw!
endfunction

" Initialize

" NOTE: '<sfile>' must be called top level
let s:plugin_root=expand('<sfile>:p:h:h')

call s:initialize()


let &cpoptions = s:save_cpo
unlet s:save_cpo
