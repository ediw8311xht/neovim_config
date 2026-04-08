
setlocal tabstop=2 shiftwidth=2 softtabstop=4 expandtab
"set filetype=commonlisp
let g:paredit_help="$MY_INFORMATION/lisp/paredit.md"
let g:vlime_help="$MY_INFORMATION/lisp/vlime.md"
let g:slimv_help="$MY_INFORMATION/lisp/slimv.md"
set commentstring=;%s
"set filetype=commonlisp
set syntax=commonlisp

inoremap <buffer> <c-p> <Cmd>call SlimvPreviousCommand()<CR>
inoremap <buffer> <c-n> <Cmd>call SlimvNextCommand()<CR>
lua <<EOF

local commonlisp_leader_mappings = {
  n = {
    x   = { false, 'execute',         '!sbcl --script "%"<CR>', cmd=true },
    X   = { false, 'execute w/ args', ':!sbcl --script "%"' },
    cf  = { false, 'format',          ':Autoformat<CR>:silent! %s/([ ]\\+/(/g<CR>' },
    hp  = { false, 'paredit help',    ':execute (":vsplit " . expand(g:paredit_help))<CR>' },
    hh  = { false, 'vlime help',      ':execute (":vsplit " . expand(g:vlime_help))<CR>' },
  }
}

KeyMapSetter(commonlisp_leader_mappings, '<leader>', true, true)
-- "nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:vlime_help))<CR>
-- nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:slimv_help))<CR>
-- nnoremap <buffer> <leader>J :join<CR>

EOF
