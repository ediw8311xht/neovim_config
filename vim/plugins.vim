
" -------------------------------------------------------------------------------------------------------- "
" -------------------------------------------------------------------------------------------------------- "
" -------------------------------------------------------------------------------------------------------- "
"Yeah, I use way too many plugins....
let g:my_plugins = {}
"-- Latex
let g:my_plugins['vim latex']           = [ 'lervag',           'vimtex'                        ]
"-- Session/View management
let g:my_plugins['auto session']        = [ 'rmagatti',         'auto-session'                  ]
let g:my_plugins['restore view']        = [ 'vim-scripts',      'restore_view.vim'              ]
"-- Documentation
"let g:my_plugins['dasht (docs)'] = [ 'sunaku',  'vim-dasht' ]
let g:my_plugins['dasht (docs)'] = [ 'sunaku',  'vim-dasht' ]
"-- Language Server
let g:my_plugins['lspconfig']           = [ 'neovim',           'nvim-lspconfig'                ]
let g:my_plugins['lsp lines']           = [ 'maan2003',         'lsp_lines.nvim'                ]
let g:my_plugins['lsp saga']            = [ 'nvimdev',          'lspsaga.nvim'                  ]
let g:my_plugins['lsp statusline']      = [ 'nvim-lua',         'lsp-status.nvim'               ]
let g:my_plugins['code-action preview'] = [ 'aznhe21',          'actions-preview.nvim'          ]
"let g:my_plugins['devicons']            = [ 'nvim-tree',        'nvim-web-devicons'             ]
"-- Scheme
let g:my_plugins['conjure']             = [ 'Olical',  'conjure' ]
"-- Lisp
let g:my_plugins['slimv']               = [ 'kovisoft', 'slimv' ]
"-- Elixir
let g:my_plugins['elixir']              = [ 'elixir-tools',     'elixir-tools.nvim'             ]
let g:my_plugins['elixirfiledetect']    = [ 'elixir-editors',   'vim-elixir'                    ]
"-- Tools
let g:my_plugins['plenary [telescope]'] = [  'nvim-lua',         'plenary.nvim'                 ]
let g:my_plugins['telescope']           = [ 'nvim-telescope',   'telescope.nvim',               { 'branch': 'master' } ]
let g:my_plugins['file explorer']       = [ 'preservim',        'nerdtree'                      ]
let g:my_plugins['neoterm']             = [ 'kassio',           'neoterm'                       ]
let g:my_plugins['markdown preview']    = [ 'iamcco',           'markdown-preview.nvim',        { 'do': 'cd app && yarn install' } ]
let g:my_plugins['luarocks for nvim']   = [ 'theHamsta',        'nvim_rocks',                   { 'do': 'pipx install hererocks && python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua'}]
let g:my_plugins['fzf']                 = [ 'junegunn',         'fzf.vim'                       ]
"-- Lf File Manager
let g:my_plugins['floatterm']           = [ 'voldikss',         'vim-floaterm'                  ]
let g:my_plugins['lf']                  = [ 'ptzz',             'lf.vim'                        ]
"-- Key Hints
let g:my_plugins['whichkeys']           = [ 'folke',            'which-key.nvim'                ]
"-- UI/Formatting/Appearance
let g:my_plugins['colorful comp menu']  = [ 'xzbdmw',           'colorful-menu.nvim'            ]
let g:my_plugins['notify (dep: noice)'] = [ 'rcarriga',         'nvim-notify'                   ]
let g:my_plugins['nui (dep: noice)']    = [ 'MunifTanjim',      'nui.nvim'                      ]
let g:my_plugins['rainbow delimeters']  = [ 'HiPhish',          'rainbow-delimiters.nvim'       ]
let g:my_plugins['autoformat']          = [ 'vim-autoformat',   'vim-autoformat'                ]
let g:my_plugins['gitsigns']            = [ 'lewis6991',        'gitsigns.nvim'                 ]
let g:my_plugins['marks']               = [ 'chentoast',        'marks.nvim'                    ]
"-- Treesitter
let g:my_plugins['treesitter']          = [ 'nvim-treesitter',  'nvim-treesitter',              { 'branch': 'main', 'do': ':TSUpdate'} ]
let g:my_plugins['treesitter-textobjs'] = [ 'nvim-treesitter',  'nvim-treesitter-textobjects',  {'branch': 'main'} ]
"-- Syntax
let g:my_plugins['Syntax i3']           = [ 'PotatoesMaster',   'i3-vim-syntax'                 ]
let g:my_plugins['Syntax lfrc']         = [ 'VebbNix',          'lf-vim'                        ]
let g:my_plugins['Syntax kitty']        = [ 'fladson',          'vim-kitty',                    { 'tag': '*' } ]
let g:my_plugins['Syntax PlantUML']     = [ 'aklt',             'plantuml-syntax'               ]
let g:my_plugins['Syntax markdown']     = [ 'drmingdrmer',      'vim-syntax-markdown'           ]
"-- Colorscheme
let g:my_plugins['tokyonight']          = [ 'folke',            'tokyonight.nvim'               ]
"-- Cmp
let g:my_plugins['nvim cmp']            = [ 'hrsh7th',          'nvim-cmp'                      ]
let g:my_plugins['cmp lsp']             = [ 'hrsh7th',          'cmp-nvim-lsp'                  ]
let g:my_plugins['cmp lua']             = [ 'hrsh7th',          'cmp-nvim-lua'                  ]
let g:my_plugins['cmp buffer']          = [ 'hrsh7th',          'cmp-buffer'                    ]
let g:my_plugins['cmp cmdline']         = [ 'hrsh7th',          'cmp-cmdline'                   ]
let g:my_plugins['cmp path']            = [ 'hrsh7th',          'cmp-path'                      ]
let g:my_plugins['cmp auto hint']       = [ 'hrsh7th',          'cmp-nvim-lsp-signature-help'   ]
let g:my_plugins['cmp omni']            = [ 'hrsh7th',          'cmp-omni'                      ]
let g:my_plugins['cmp dictionary']      = [ 'uga-rosa',         'cmp-dictionary'                ]
let g:my_plugins['cmp env']             = [ 'SergioRibera',     'cmp-dotenv'                    ]
let g:my_plugins['cmp luasnip']         = [ 'saadparwaiz1',     'cmp_luasnip'                   ]
let g:my_plugins['cmp plain english']   = [ 'uga-rosa',         'cmp-dictionary'                ]
let g:my_plugins['cmp nvim tags']       = [ 'quangnguyen30192', 'cmp-nvim-tags'                 ]
let g:my_plugins['cmp ctags']           = [ 'delphinus',        'cmp-ctags'                     ]
let g:my_plugins['cmp treesitter']      = [ 'ray-x',            'cmp-treesitter'                ]
let g:my_plugins['cmp conjure']         = [ 'PaterJason',       'cmp-conjure'                   ]
let g:my_plugins['latex snips 4 vimtex']= [ 'micangl',          'cmp-vimtex'                    ]
let g:my_plugins['luasnip']             = [ 'L3MON4D3',         'LuaSnip'                       ]
" -------------------------------------------------------------------------------------------------------- "
" -------------------------------------------------------------------------------------------------------- "
" -------------------------------------------------------------------------------------------------------- "

fu! MyInstallPlugin(plg) 
    let l:len = len(a:plg)

    if l:len == 2
        Plug a:plg[0] . '/' . a:plg[1]
    elseif l:len == 3
        Plug a:plg[0] . '/' . a:plg[1], a:plg[2]
    endif
endfu

call plug#begin()
    for plugin in values(g:my_plugins)
        call MyInstallPlugin(plugin)
    endfor
    " Breaks everything
    "Plug 'soemre/commentless.nvim'
    Plug 'AndrewRadev/tagalong.vim'
    Plug 'alvan/vim-closetag'
call plug#end()
