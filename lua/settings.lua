
vim.filetype.add({
  extension = {
    [ 'ex'             ] = 'elixir',
    [ 'exs'            ] = 'elixir',
    [ 'hs'             ] = 'haskell',
    [ 'kalker'         ] = 'kalker',
    [ 'lisp'           ] = 'lisp',
    [ 'page'           ] = 'markdown',
    [ 'schema'         ] = 'sql',
    [ 'scm'            ] = 'scheme',
    [ 'sh'             ] = 'bash',
    [ 'kitty-session'  ] = 'kitty-session',
    [ 'md'             ] = "markdown",
  },
  pattern = {
    [ '${HOME}/bashrc_files/.*'            ] = 'bash',
    [ '${XDG_CONFIG_HOME}/polybar/.*%.ini' ] = 'dosini',
    [ '${XDG_CONFIG_HOME}/i3/.*'           ] = 'i3',
    [ '${XDG_CONFIG_HOME}/zathura/.*'      ] = 'zathurarc',
  }
})
