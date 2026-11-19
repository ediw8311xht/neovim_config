
vim.g.my_plugins =  {
  misc = {
    -- graphical_undo      =  {  user='sjl',              repo='gundo.vim'  },
    colorful_comp_menu  =  {  user='xzbdmw',           repo='colorful-menu.nvim'  },
    gitsigns            =  {  user='lewis6991',        repo='gitsigns.nvim'  },
    marks               =  {  user='chentoast',        repo='marks.nvim'  },
    nui                 =  {  user='MunifTanjim',      repo='nui.nvim'  },
    plenary             =  {  user='nvim-lua',         repo='plenary.nvim', notes="needed for telescope/ java stuff", },
    rainbow_delimeters  =  {  user='HiPhish',          repo='rainbow-delimiters.nvim'  },
    view_images         =  {  user='3rd',              repo='image.nvim'  },
  },
  ui = {
    devicons   = {  user='nvim-tree', repo='nvim-web-devicons' },
    floatterm           =  {  user='voldikss',         repo='vim-floaterm'  },
    mini_icons = {  user='nvim-mini', repo='mini.icons' },
    notify              =  {  user='rcarriga',         repo='nvim-notify'  },
  },
  tools = {
    autoformat          = {  user='vim-autoformat',   repo='vim-autoformat'  },
    easy_align          = {  user='junegunn',         repo='vim-easy-align'  },
    fzf                 = {  user='junegunn',         repo='fzf.vim'  },
    lf                  = {  user='ptzz',             repo='lf.vim'  },
    neoterm             = {  user='kassio',           repo='neoterm'  },
    nvim_tree           = {  user='nvim-tree',        repo='nvim-tree.lua' },
    outline             = {  user='hedyhli',          repo='outline.nvim' },
    spectre_sub_buffers = {  user='nvim-pack',        repo='nvim-spectre' },
    telescope           = {  user='nvim-telescope',   repo='telescope.nvim', args={ branch = 'master'  }  },
    whichkeys           = {  user='folke',            repo='which-key.nvim'  },
  },
  html_css_js = {
    bracey              = {  user='turbio',           repo='bracey.vim', args={ ['do']='npm install --prefix server' } },
  },
  latex = {
    vim_latex           =  {  user='lervag',           repo='vimtex'  },
    latex_snips_vimtex  =  {  user='micangl',          repo='cmp-vimtex'  },
  },
  session = {
    auto_session        =  {  user='rmagatti',         repo='auto-session'  },
    restore_view        =  {  user='vim-scripts',      repo='restore_view.vim'  },
  },
  documentation = { }, 
  lsp = {
    lspconfig           =  {  user='neovim',           repo='nvim-lspconfig'  },
    lsp_lines           =  {  user='maan2003',         repo='lsp_lines.nvim'  },
    lsp_statusline      =  {  user='nvim-lua',         repo='lsp-status.nvim'  },
    lsp_saga            =  {  user='nvimdev',          repo='lspsaga.nvim'  },
    code_action_preview =  {  user='aznhe21',          repo='actions-preview.nvim'  },
  },
  tcl = {
    nvim_lint           =  {  user='mfussenegger',     repo='nvim-lint'  },
  },
  lisp = {
    paredit             =  {  user='julienvincent',    repo='nvim-paredit', args={ ['for']={'clojure', 'fennel', 'scheme' }  }  },
    nfnl__fennel        =  {  user='Olical',           repo='nfnl'        },
    conjure             =  {  user='Olical',           repo='conjure'     },
    slimv               =  {  user='ediw8311xht',      repo='slimv-neovim', args={ ['for']={ 'lisp', 'commonlisp'  }  }  },
    cl_lsp              =  {  user='cxxxr',            repo='cl-lsp',       args={ ['for']={ 'lisp', 'commonlisp'  }  }  },
  },
  java = {
    dap         = { user='mfussenegger', repo='nvim-dap' },         -- required for nvim-java
    spring_boot = { user='JavaHello',    repo='spring-boot.nvim' }, -- required for nvim-java
    java        = { user='nvim-java',    repo='nvim-java' },
  },
  elixir = {
    elixir              =  {  user='elixir-tools',     repo='elixir-tools.nvim'  },
    elixirfiledetect    =  {  user='elixir-editors',   repo='vim-elixir'         },
  },
  ts = {
    treesitter          =  {  user='nvim-treesitter',  repo='nvim-treesitter',             args={ branch='main', ['do']=':TSUpdate' }  },
    treesitter_textobjs =  {  user='nvim-treesitter',  repo='nvim-treesitter-textobjects', args={ branch='main'  }  },
  },
  markdown = {
    markdown_preview  = {  user='iamcco',               repo='markdown-preview.nvim',           args={ ['do']='cd app && yarn install'  }  },
    myst              = {  user='QuantEcon',            repo='myst-markdown-tree-sitter.nvim',  args={ ["for"]={"myst", "markdown"} } },
    syntax_markdown   = {  user='drmingdrmer',          repo='vim-syntax-markdown'  },
    markdown_render   = {  user='MeanderingProgrammer', repo='render-markdown.nvim' },
  },
  syntax_colorscheme = {
    PlantUML        = {  user='aklt',             repo='plantuml-syntax'  },
    i3              = {  user='PotatoesMaster',   repo='i3-vim-syntax'  },
    kitty           = {  user='fladson',          repo='vim-kitty', args={ tag='*'  }  },
    lfrc            = {  user='VebbNix',          repo='lf-vim'  },
    tokyonight      = {  user='folke',            repo='tokyonight.nvim'  },
  },
  completion = {
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
    luasnip             =  {  user='L3MON4D3',         repo='LuaSnip', args={ run="make install_jsregexp" } },
  }
}

local function install_plugins()
  vim.call("plug#begin")
  for _,t in pairs(vim.g.my_plugins) do
    for _,v in pairs(t) do
      vim.cmd.Plug { args = { Printf("'%s/%s'", v.user, v.repo), unpack(v.args or {}) } }
    end
  end
  vim.cmd.Plug(  '"AndrewRadev/tagalong.vim"' )
  vim.cmd.Plug(  '"alvan/vim-closetag"'       )
  vim.call("plug#end")
end

install_plugins()

--let g:my_plugins['devicons'] = [ 'nvim-tree', 'nvim-web-devicons' ]
--let g:my_plugins['nvim-thyme (fennel)'] = [ 'aileot', 'nvim-thyme' ]
--"Breaks everything
--Plug 'soemre/commentless.nvim'

