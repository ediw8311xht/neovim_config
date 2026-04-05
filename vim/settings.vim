

let g:python3_host_prog="/usr/bin/python"

filetype on
filetype plugin on
syntax enable
"set tags=$HOME/.config/.ctags
set title
set shada=!,'500,<2000,:200,s100,h
set termguicolors
set autoread
set nocindent
set backup
set clipboard=unnamedplus
set encoding=utf-8
set formatoptions=tcqrn1
set hidden
set magic
set modelines=5
set nocompatible
set nowrap
"-------------------line numbers 
set number
set relativenumber
set ruler
"set splitright
set nosplitbelow
set nosplitright
set t_Co=256
set textwidth=0
set undofile
set undolevels=10000
set undoreload=10000
set updatetime=400
let nvim_backup_swap = $HOME . '/.mynvim/' . getpid()
silent! call mkdir(vimtmp, "p", 0700)
let &backupdir=nvim_backup_swap
let &directory=nvim_backup_swap
set undodir=~/.mynvim/undo_dir
set timeoutlen=500
set ttimeoutlen=0
set wildmode=longest,list,full
set wildignore=*.o,*.a,__pycache__
set showmode
set virtualedit=none
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set backspace=2
set guicursor=n:block90,i:ver20
set cul
set nocuc
set cedit=\<C-c>
set signcolumn=auto:4
"set statuscolumn=%@SignFunction@%s%=%T%@NumCb@%l│%T
set statuscolumn=%@v:lua.GutterSign@%s%=%T%@v:lua.GutterNum@%l\ %T
"set statuscolumn=%@SignCb@%s%=%T%@NumCb@%l│%T
set foldmethod=marker
set foldmarker={{{,}}}
set foldcolumn=1
set sessionoptions=blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,folds
set viewoptions=cursor,folds
set fillchars=fold:\ ,horiz:█,vert:░ 
set background=dark
set scrolloff=8
"for fennel nfnl
autocmd FileType bash setlocal keywordprg=:Man

let g:mapleader = " "
let g:maplocalleader = ","

"------------------- Plugin options -------------------"
let g:NERDTreeIgnore             = ['\.o$','.cache$','.git$']
let g:floaterm_opener            = 'edit'
let g:html_mode                  = 1
let g:is_bash                    = 1
let g:markdown_recommended_style = 0
let g:vimwiki_global_ext         = 0 "Prevent vimwiki from running on markdown not in ~/vimwiki dir.
"let g:neoterm_automap_keys=',Tt'

"--------------------------------------------vim-autoformat
":Autoformat
let g:formatterpath = [ '/usr/bin/' ]
let g:formatters_bash = [ 'shfmt' ]
let g:formatdef_fnlfmt = '"fnlfmt -"'
let g:formatters_fennel = [ 'fnlfmt' ]

"--------------------------------------------LF
let g:lf_height   = 0.9
let g:lf_map_keys = 0
let g:lf_width    = 0.9

"-------------------------------------lf
let g:NERDTreeHijackNetrw = 0 " Add this line if you use NERDTree
let g:lf_replace_netrw    = 1
let g:loaded_netrw        = 1

lua <<EOF
-- eventually will move this to settings.vim
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
EOF

