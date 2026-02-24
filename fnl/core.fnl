(local {: autoload} (require :nfnl.module))

(fn setup []
  (print :HI) ; just testing
  (vim.keymap.set :n :<leader>AB ":tabnew <CR>" {:desc :newtab :noremap true}))


; (print a b)
; (setup)
