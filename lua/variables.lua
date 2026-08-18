-- {{{
-- vim.api.nvim_set_hl
-- vim.highlight.create
-- }}}

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

vim.g.my_statuslines = {
  default = "%!v:lua.StatusLineFunc()",
}

vim.g.my_titlestring = {
  default = "%{v:lua.TitleStringFunc()}",
}

vim.g.my_tabline = {
  default = "%!v:lua.TabLineFunc()",
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
