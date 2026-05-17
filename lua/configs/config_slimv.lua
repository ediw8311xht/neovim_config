
-- " note to self: don't set slimv_disable_clojure to 1, messes with lisp
-- "let g:slimv_disable_clojure = 1 "disable for clojure
-- "let g:slimv_disable_scheme = 1 "disable for scheme
function LispConnectSwank()
  local dir = vim.g.project_directory or vim.fn.getcwd()
  vim.cmd['!'] {
    'kitty @ launch',
      '--type=tab',
      '--location=first',
      '--tab-title="swank"',
      '--keep-focus',
      vim.fn.printf("--cwd='%s'", dir),
    'sbcl',
      '--load', '"${XDG_DATA_HOME}/nvim/plugged/slimv/slime/start-swank.lisp"',
    '&'
  }
end
vim.g.paredit_leader     = '-'
vim.g.slimv_impl         = 'sbcl'       -- sbcl
vim.g.slimv_leader       = '\\'
vim.g.slimv_menu         = 1            -- enable slimv menu
vim.g.slimv_repl_name    = 'cl-repl'    -- repl buffer name
vim.g.slimv_repl_split   = 3            -- split left
vim.g.slimv_repl_syntax  = 1            -- enable syntax highlighting in repl
vim.g.slimv_swank_path   = vim.fn.expand('~/quicklisp/slime-helper.el')
vim.g.slimv_balloon      = 1
vim.g.slimv_strip_ansi   = 1
vim.g.slimv_swank_cmd    = 'lua LispConnectSwank()'


-- lua <<EOF
-- if vim.fn.executable("zeal") then
--   vim.g.slimv_browser_cmd="zeal"
--   vim.g.slimv_clhs_root="dash://common_lisp/HyperSpec/HyperSpec/Body/"
-- end
-- EOF
function LispSetup()
  if vim.fn.exists("*PareditInitBuffer") == 1 then
    vim.fn.PareditInitBuffer()
  end
end

vim.api.nvim_create_autocmd( {"BufWinEnter"}, {
  pattern = { "*.lisp", "*.asd" },
  callback = LispSetup
})
