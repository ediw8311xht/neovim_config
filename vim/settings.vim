

let g:python3_host_prog="/usr/bin/python"

filetype on
filetype plugin on
syntax enable
"set tags=$HOME/.config/.ctags
set title
set shada=!,'500,<200,:100,s10,h
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
set signcolumn=auto:1-5
set splitright
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
set backup
set timeoutlen=500
set ttimeoutlen=0
set wildmode=longest,list,full
set showmode
set virtualedit=none
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2
set guicursor=n:block90,i:ver20
set cul
set nocuc
set cedit=\<C-c>
set statuscolumn=
set foldmethod=manual
set foldcolumn=2
set sessionoptions=blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,folds
set viewoptions=cursor,folds
"set fillchars=fold:\ ,horiz:█,vert:█
set fillchars=fold:\ ,horiz:█,vert:░ 
"set fillchars=fold:\ ,horiz:\ ,vert:\ 
set background=dark
autocmd FileType bash setlocal keywordprg=:Man

let g:mapleader = " "
let g:maplocalleader = ","

"------------------- Plugin options -------------------"
let g:NERDTreeIgnore = ['\.o$']
let g:floaterm_opener='edit'
let g:html_mode      = 1
let g:is_bash        = 1
let g:markdown_recommended_style=0
let g:neoterm_automap_keys=',Tt'
let g:vimwiki_global_ext = 0 "Prevent vimwiki from running on markdown not in ~/vimwiki dir.

"--------------------------------------------LF
let g:lf_height=0.9
let g:lf_map_keys    = 0
let g:lf_width=0.9
"-------------------------------------Tex/Latex
let g:tex_flavor='latex'
let g:vimtex_compiler_latexmk = { 'out_dir' : '/tmp', }
let g:vimtex_quickfix_mode=0
let g:vimtex_view_continuous=1
let g:vimtex_view_method='zathura'

