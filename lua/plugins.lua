
vim.g.my_plugins =  {
  -- Latex
  vim_latex           =  {  user='lervag',           repo='vimtex'  },
  -- Session/View management
  auto_session        =  {  user='rmagatti',         repo='auto-session'  },
  restore_view        =  {  user='vim-scripts',      repo='restore_view.vim'  },
  -- Documentation
  -- Language Server
  lspconfig           =  {  user='neovim',           repo='nvim-lspconfig'  },
  lsp_lines           =  {  user='maan2003',         repo='lsp_lines.nvim'  },
  lsp_statusline      =  {  user='nvim-lua',         repo='lsp-status.nvim'  },
  lsp_saga            =  {  user='nvimdev',          repo='lspsaga.nvim'  },
  code_action_preview =  {  user='aznhe21',          repo='actions-preview.nvim'  },
  -- Tcl
  nvim_lint           =  {  user='mfussenegger',     repo='nvim-lint'  },
  -- Paredit
  paredit             =  {  user='julienvincent',    repo='nvim-paredit', args={ ['for']={'clojure', 'fennel', 'scheme'}  }  },
  -- Fennel for neovim
  nfnl__fennel        =  {  user='Olical',           repo='nfnl'  },
  -- Scheme
  conjure             =  {  user='Olical',           repo='conjure'  },
  -- Lisp
  slimv               =  {  user='ediw8311xht',      repo='slimv-neovim', args={ ['for']={ 'lisp', 'commonlisp'  }  }  },
  cl_lsp              =  {  user='cxxxr',            repo='cl-lsp',       args={ ['for']={ 'lisp', 'commonlisp'  }  }  },
  -- Elixir
  elixir              =  {  user='elixir-tools',     repo='elixir-tools.nvim'  },
  elixirfiledetect    =  {  user='elixir-editors',   repo='vim-elixir'  },
  -- UI/Formatting/Appearance
  graphical_undo      =  {  user='sjl',              repo='gundo.vim'  },
  floatterm           =  {  user='voldikss',         repo='vim-floaterm'  },
  colorful_comp_menu  =  {  user='xzbdmw',           repo='colorful-menu.nvim'  },
  notify              =  {  user='rcarriga',         repo='nvim-notify'  },
  nui                 =  {  user='MunifTanjim',      repo='nui.nvim'  },
  rainbow_delimeters  =  {  user='HiPhish',          repo='rainbow-delimiters.nvim'  },
  autoformat          =  {  user='vim-autoformat',   repo='vim-autoformat'  },
  gitsigns            =  {  user='lewis6991',        repo='gitsigns.nvim'  },
  marks               =  {  user='chentoast',        repo='marks.nvim'  },
  view_images         =  {  user='3rd',              repo='image.nvim'  },
  -- Tools
  plenary_telescope   =  {  user='nvim-lua',         repo='plenary.nvim'  },
  telescope           =  {  user='nvim-telescope',   repo='telescope.nvim', args={ branch = 'master'  }  },
  file_explorer       =  {  user='preservim',        repo='nerdtree'  },
  neoterm             =  {  user='kassio',           repo='neoterm'  },
  markdown_preview    =  {  user='iamcco',           repo='markdown-preview.nvim', args={ ['do']='cd app && yarn install'  }  },
  fzf                 =  {  user='junegunn',         repo='fzf.vim'  },
  easy_align          =  {  user='junegunn',         repo='vim-easy-align'  },
  -- Lf File Manager
  lf                  =  {  user='ptzz',             repo='lf.vim'  },
  -- Search & Replace
  spectre_sub_buffers =  {  user='nvim-pack',        repo='nvim-spectre' },
  -- Key Hints
  whichkeys           =  {  user='folke',            repo='which-key.nvim'  },
  -- Treesitter
  treesitter          =  {  user='nvim-treesitter',  repo='nvim-treesitter', args={ branch='main', ['do']=':TSUpdate'}  },
  treesitter_textobjs =  {  user='nvim-treesitter',  repo='nvim-treesitter-textobjects', args={ branch='main'  }  },
  -- Syntax
  syntax_i3           =  {  user='PotatoesMaster',   repo='i3-vim-syntax'  },
  syntax_lfrc         =  {  user='VebbNix',          repo='lf-vim'  },
  syntax_kitty        =  {  user='fladson',          repo='vim-kitty', args={ tag='*'  }  },
  syntax_PlantUML     =  {  user='aklt',             repo='plantuml-syntax'  },
  syntax_markdown     =  {  user='drmingdrmer',      repo='vim-syntax-markdown'  },
  -- Color scheme
  tokyonight          =  {  user='folke',            repo='tokyonight.nvim'  },
  -- Cmp
  nvim_cmp            =  {  user='hrsh7th',          repo='nvim-cmp'  },
  cmp_lsp             =  {  user='hrsh7th',          repo='cmp-nvim-lsp'  },
  cmp_lua             =  {  user='hrsh7th',          repo='cmp-nvim-lua'  },
  cmp_buffer          =  {  user='hrsh7th',          repo='cmp-buffer'  },
  cmp_cmdline         =  {  user='hrsh7th',          repo='cmp-cmdline'  },
  cmp_path            =  {  user='hrsh7th',          repo='cmp-path'  },
  cmp_auto_hint       =  {  user='hrsh7th',          repo='cmp-nvim-lsp-signature-help'  },
  cmp_omni            =  {  user='hrsh7th',          repo='cmp-omni'  },
  cmp_dictionary      =  {  user='uga-rosa',         repo='cmp-dictionary'  },
  cmp_env             =  {  user='SergioRibera',     repo='cmp-dotenv'  },
  cmp_luasnip         =  {  user='saadparwaiz1',     repo='cmp_luasnip'  },
  cmp_plain_english   =  {  user='uga-rosa',         repo='cmp-dictionary'  },
  cmp_nvim_tags       =  {  user='quangnguyen30192', repo='cmp-nvim-tags'  },
  cmp_ctags           =  {  user='delphinus',        repo='cmp-ctags'  },
  cmp_treesitter      =  {  user='ray-x',            repo='cmp-treesitter'  },
  cmp_conjure         =  {  user='PaterJason',       repo='cmp-conjure'  },
  latex_snips_vimtex  =  {  user='micangl',          repo='cmp-vimtex'  },
  luasnip             =  {  user='L3MON4D3',         repo='LuaSnip', args={ run="make install_jsregexp" } },
}

local function install_plugins()
  vim.call("plug#begin")
  for _,v in pairs(vim.g.my_plugins) do
    vim.cmd.Plug { args = { Printf("'%s/%s'", v.user, v.repo), unpack(v.args or {}) } }
  end
  vim.cmd.Plug { args = { '"AndrewRadev/tagalong.vim"' } }
  vim.cmd.Plug { args = { '"alvan/vim-closetag"' } }
  vim.call("plug#end")
end

install_plugins()

--let g:my_plugins['devicons'] = [ 'nvim-tree', 'nvim-web-devicons' ]
--let g:my_plugins['nvim-thyme (fennel)'] = [ 'aileot', 'nvim-thyme' ]
--"Breaks everything
--Plug 'soemre/commentless.nvim'

