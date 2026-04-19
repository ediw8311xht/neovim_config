
" note to self: don't set slimv_disable_clojure to 1, messes with lisp
"let g:slimv_disable_clojure = 1 "disable for clojure
"let g:slimv_disable_scheme = 1 "disable for scheme
let g:paredit_leader     = '-'          "[
let g:slimv_impl         = 'sbcl'       "sbcl
let g:slimv_leader       = '\'         "\
let g:slimv_menu         = 1            "enable slimv menu
let g:slimv_repl_name    = 'cl-repl'    "repl buffer name
let g:slimv_repl_split   = 3            "split left
let g:slimv_repl_syntax  = 1            "enable syntax highlighting in repl
let g:slimv_swank_path   = expand('~/quicklisp/slime-helper.el')
let g:slimv_balloon      = 1
let g:slimv_strip_ansi   = 1
let g:slimv_swank_cmd = '! kitty @ launch --type=tab --location=first --keep-focus --tab-title="slimv" sbcl --load "${XDG_DATA_HOME}/nvim/plugged/slimv/slime/start-swank.lisp" &'


"lua <<EOF
"if vim.fn.executable("zeal") then
"  vim.g.slimv_browser_cmd="zeal"
"  vim.g.slimv_clhs_root="dash://common_lisp/HyperSpec/HyperSpec/Body/"
"end
"EOF

fu! SetupForLisp()
  if exists("*PareditInitBuffer")
    call PareditInitBuffer()
  endif
endfu

autocmd BufWinEnter *.lisp call SetupForLisp()
"autocmd BufWinEnter *.lisp set syntax=lisp "makes :Autoformat run a lot slower for some reason...
" ------------------------------------------- INFO -------------------------------- "
"                                                             *g:slimv_repl_split*  "
"  Open the Lisp REPL buffer in a split window or in a separate buffer in Vim.      "
"  The default is to use split window. If you prefer having REPL being in a hidden  "
"  buffer then set this option to zero. This way the REPL buffer will be opened     "
"  at the first evaluation, but any subsequent evaluation will be performed         "
"  silently, with the REPL buffer kept hidden.                                      "
"                                                                                   "
"  It is also possible to define the desired split direction. The following         "
"  values may be used for |g:slimv_repl_split|:                                     "
"                                                                                   "
"      0: no split                                                                  "
"      1: horizontal split above (default)                                          "
"      2: horizontal split below                                                    "
"      3: vertical split left                                                       "
"      4: vertical split right                                                      "
"                                                                                   "
" --------------------------------------------------------------------------------- "
