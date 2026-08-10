-- {{{
-- vim.api.nvim_set_hl
-- vim.highlight.create
-- }}}

vim.g.treesitter_disable = { tex = true }
vim.g.treesitter_with_vim_regex_highlighting = { lua = true }
vim.g.python3_host_prog="/usr/bin/python"
vim.g.MyDefaultScheme = { 'pop-punk', 'lua CorrectColors()' }
vim.g.MySchemes = {
    vim.g.MyDefaultScheme ,
    { 'wildcharm'      ,   "."  },
    { 'cyberpunk-neon' ,   "."  },
    { 'eldar'          ,   "."  },
    { 'elflord'        ,   "."  },
    { 'delek'          ,   "."  },
    { 'morning'        ,   "."  },
    { 'blue'           ,   "."  },
    { 'peachpuff'      ,   "."  },
    { 'industry'       ,   "."  },
    { 'murphy'         ,   "."  },
    { 'vividchalk'     ,   "."  },
    { 'everforest'     ,   "."  },
}

vim.g.MyColorTable = {
  { "NONE",    "."        },
  { "#333333", "."        },
  { "#111111", "."        },
  { "#220000", "."        },
  { "#002200", "."        },
  { "#000022", "."        },
  { "#002244", "#AAAAAA"  },
  { "#999999", "#000000"  },
  { "#AAAAAA", "#000000"  },
}


vim.g.my_floating_preview_options = {
  border = 'rounded',
  max_height = 200,
  max_width = 200,
  offset_x = 20,
}

-- local sl_lsp_status = "" .. "%{LspStatus()}" .. "%*"

vim.g.my_statuslines = {
  { 'default' , "%!v:lua.StatusLineFunc()"},
  -- { 'medium'  , sl_file .. sl_git_branch .. sl_session .. "%m%=" .. sl_lsp_status .. sl_filepath },
  -- { 'large'   , sl_file .. sl_git_status .. sl_session .. "%m%=" .. sl_lsp_status .. "[%l,%c,%p%%]" .. sl_filepath },
}

vim.g.my_titlestring = {
  -- default = "%f",
  default = "%{v:lua.TitleStringFunc()}",
}
----------------------------------------------------------
---------------------- FZF SETTINGS ----------------------
----------------------------------------------------------
vim.g.fzf_vim = {
  [ 'buffers_options' ] = {
    '--style'        ,  'full'      ,
    '--border-label' ,  "Buffers"   ,
    -- '--nth'          ,  '-1'        ,
    -- '--with-nth'     ,  '{-1}'      ,
  },
  [ 'colors_options' ] = {
    '--style'        ,  'full'      ,
    '--border-label' ,  "Colors"   ,
  },
  [ 'preview_window' ] = {
    'right,50%,<70(up,40%)', 'ctrl-/'
  }
}
vim.g.fzf_colors = {
  hl      = { 'bg', 'Search' },
  ['hl+'] = { 'bg', 'Search' },
  -- [ 'border' ] = { 'bg', 'Ignore' },
}
vim.g.fzf_layout = {
  window  = { width = 0.9, height = 0.9, border = "sharp" } --, border = 'no' }
}

vim.g.fullscreen_window_toggle = {
  command_name = "ToggleFullscreen",
  namespace = "fullscreen",
  scope = "t",
  var = "is_fullscreen",
  on = function()
    vim.t.fullscreen_state = vim.fn.winrestcmd()
    vim.cmd([[
        vertical resize
        horizontal resize
    ]])
    return "fullscreen"
  end,
  off = function()
    vim.cmd.execute("t:fullscreen_state")
    return "normal"
  end,
}
