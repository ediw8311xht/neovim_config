
setlocal tabstop=2 shiftwidth=2 softtabstop=4 expandtab
"set filetype=commonlisp
let g:paredit_help="$MY_INFORMATION/lisp/paredit.md"
"let g:vlime_help="$MY_INFORMATION/lisp/vlime.md"
let g:slimv_help="$MY_INFORMATION/lisp/slimv.md"
set commentstring=;%s
"set filetype=commonlisp
set syntax=commonlisp
set filetype=lisp " ensure for slimv

inoremap <buffer> <c-p> <Cmd>call SlimvPreviousCommand()<CR>
inoremap <buffer> <c-n> <Cmd>call SlimvNextCommand()<CR>
lua <<EOF

local commonlisp_leader_mappings = {
  n = {
    x   = { false, 'execute [sbcl]',         '!sbcl --script "%"', cmd=true },
    X   = { false, 'execute [sbcl] w/ args', ':!sbcl --script "%" ' },
    cf  = { false, 'format',          'Autoformat | silent! %s/([ ]\\+/(/g', cmd=true },
    hp  = { false, 'paredit help',    'execute (":vsplit " . expand(g:paredit_help))', cmd=true },
    hh  = { false, 'slime help',      'execute (":vsplit " . expand(g:slime_help))', cmd=true },
    Ae  = { false, "slimv eval put into 'e" ,   '"e\\e' },
    Ar  = { false, 'reload slimv',    '\\Q\\c' },
    Af  = { false, 'reload slimv',    '\\Q\\c' },
    Al  = { false, 'load system',     'SlimvEvalForm("(asdf:load-system :" .. g:Session_system .. ")")', vim_command=true },
    At  = { false, 'load system',     'SlimvEvalForm("(asdf:test-system :" .. g:Session_system .. ")")', vim_command=true },
    -- Se  = { false, 'slimv eval at mark e',      '\'e' },
  }
}

KeyMapSetter(commonlisp_leader_mappings, '<leader>', true, true)
-- "nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:vlime_help))<CR>
-- nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:slimv_help))<CR>
-- nnoremap <buffer> <leader>J :join<CR>

EOF
