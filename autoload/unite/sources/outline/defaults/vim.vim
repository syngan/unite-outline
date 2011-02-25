"=============================================================================
" File    : autoload/unite/sources/outline/defaults/vim.vim
" Author  : h1mesuke <himesuke@gmail.com>
" Updated : 2011-02-25
"
" Licensed under the MIT license:
" http://www.opensource.org/licenses/mit-license.php
"
"=============================================================================

" Default outline info for Vim script
" Version: 0.1.0

function! unite#sources#outline#defaults#vim#outline_info()
  return s:outline_info
endfunction

let s:outline_info = {
      \ 'heading-1': '^\s*"\s*[-=]\{10,}\s*$',
      \ 'heading'  : '^\s*fu\%[nction]!\= ',
      \ 'skip': { 'header': '^"' },
      \}

function! s:outline_info.create_heading(which, heading_line, matched_line, context)
  let heading = {
        \ 'word' : a:heading_line,
        \ 'level': 0,
        \ 'type' : 'generic',
        \ }

  if a:which ==# 'heading-1' && a:heading_line =~ '^\s*"'
    let heading.type = 'comment'
    let heading.level = unite#sources#outline#
          \util#get_comment_heading_level(a:matched_line, 5)
  elseif a:which ==# 'heading'
    let heading.level = 4
    let heading.type = 'function'
  endif

  if heading.level > 0
    let heading.word = substitute(heading.word, '"\=\s*{{{\d\=\s*$', '', '')
    return heading
  else
    return {}
  endif
endfunction

" vim: filetype=vim
