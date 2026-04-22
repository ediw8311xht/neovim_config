

--set filetype=commonlisp
vim.g.paredit_help   = "$MY_INFORMATION/lisp/paredit.md"
vim.g.vlime_help     = "$MY_INFORMATION/lisp/vlime.md"
vim.g.slimv_help     = "$MY_INFORMATION/lisp/slimv.md"
--- set filetype=commonlisp
vim.bo.commentstring  = ";%s"
vim.bo.tabstop        = 2
vim.bo.shiftwidth     = 2
vim.bo.softtabstop    = 4
vim.bo.expandtab      = true
vim.bo.syntax         = "commonlisp"
vim.bo.filetype       = "lisp" -- ensure for slimv


local commonlisp_leader_mappings = {
  n = {
    x   = { false, 'execute [sbcl]',         '!sbcl --script "%"', cmd=true },
    X   = { false, 'execute [sbcl] w/ args', ':!sbcl --script "%" ' },
    cf  = { false, 'format',          'Autoformat | silent! %s/([ ]\\+/(/g', cmd=true },
    hp  = { false, 'paredit help',    'execute (":vsplit " .. expand(g:paredit_help))', cmd=true },
    hh  = { false, 'slime help',      'execute (":vsplit " .. expand(g:slime_help))', cmd=true },
    Ae  = { false, "slimv eval put into 'e" ,   '"e\\e' },
    Ar  = { false, 'reload slimv',    '\\Q\\c' },
    Af  = { false, 'reload slimv',    '\\Q\\c' },
    Al  = { false, 'load system',     'SlimvEvalForm("(asdf:load-system :" .. g:Session_system .. ")")', vim_command=true },
    At  = { false, 'test system',     'SlimvEvalForm("(asdf:test-system :" .. g:Session_system .. ")")', vim_command=true },
    -- Se  = { false, 'slimv eval at mark e',      '\'e' },
  }

}

local commonlisp_mappings = {
  i = {
    [ "<C-p>" ] = { false, 'slimv previous command', 'call SlimvPreviousCommand()', cmd=true },
    [ "<C-n>" ] = { false, 'slimv next command', 'call SlimvNextCommand()', cmd=true },
  }
}
KeyMapSetter(commonlisp_mappings, '<leader>', true, true)
KeyMapSetter(commonlisp_leader_mappings, '<leader>', true, true)
-- "nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:vlime_help))<CR>
-- nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:slimv_help))<CR>
-- nnoremap <buffer> <leader>J :join<CR>

