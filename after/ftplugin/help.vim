"
"let pattern_a = join(["'", '\l{2,}', "'"], '')
"let pattern_b = join(['[\|]', '\zs\S+\ze','[\|]'], '')
"let combined  = join([pattern_a, pattern_b], '\|') 
"
"let g:bindings_help_buffer=[
"    \[  'CR',   '<C-]>'],
"    \[  'BS',   '<C-T>'],
"    \[  'o',    join(['/\v(', combined, ')<CR>' ], '')   ],
"    \[  'O',    join(['?\v(', combined, ')<CR>' ], '')   ],
"\]
""call M_Map('nnoremap', g:bindings_help_buffer)
""call M_Map("nnoremap <buffer>", g:bindings_help_buffer)
"
"nnoremap <buffer> o '/\"f\"
""autocmd TermOpen * setlocal statusline=%{b:term_title}
"
""autocmd FileType help call call('M_Map', mapping_g + ['o'] + [bar])
""autocmd FileType help nnoremap <buffer> O ?'\l\{2,\}'<CR>
"
""autocmd FileType help nnoremap <buffer> o /'\l\{2,\}'<CR>
""autocmd FileType help nnoremap <buffer> O ?'\l\{2,\}'<CR>
"
""autocmd FileType help nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
""autocmd FileType help nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>
""autocmd FileChangedShellPost * "\ echohl WarningMsg | echo "File changed on by external program (not nvim). Buffer reloaded." | echohl None
"
"
"
