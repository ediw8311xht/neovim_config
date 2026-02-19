(local {: autoload} (require :nfnl.module))

(set vim.g.mapleader " ")
(set vim.g.mapleader " ")
(vim.keymap.set :n :<leader>AA ":tabnew" {:desc "newtab" :noremap true})
(fn setup []
  (print "HI")
  ; just testing
  (vim.keymap.set :n :<leader>AA ":tabnew" {:desc "newtab" :noremap true})
)
(setup)


