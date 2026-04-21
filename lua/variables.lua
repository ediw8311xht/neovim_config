-- {{{
-- vim.api.nvim_set_hl
-- vim.highlight.create
-- }}}
vim.g.treesitter_disable = { tex = true }
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

function StatusGit() return vim.g.gitsigns_head or "" end

-- local sl_lsp_status = "" .. "%{LspStatus()}" .. "%*"
local sl_file       = "%#StatusLine_File#" .. " %t %r" .. "%*"
local sl_git_branch = "%#StatusLine_Git#" .. " %{v:lua.StatusGit()} " .. "%*"
local sl_session    = "%#StatusLine_Session#" .. " %{v:lua.require('auto-session.lib').current_session_name()} " .. "%*"
local sl_lsp_status = "%#StatusLine_Lsp#" .. " %{LspStatus()} " .. "%*"
local sl_filepath   = " %F "

function StatusLineFunc()
  if vim.g.statusline_winid == vim.fn.win_getid() then
    return vim.fn.printf("%s %s %s %s%s", sl_file, sl_git_branch, sl_session, "%m%=", sl_lsp_status)
  else
    return vim.fn.printf("%s[%s][%s]%s%s", sl_file, sl_git_branch, sl_session, "%m%=", sl_lsp_status)
  end
end

vim.g.my_statuslines = {
  { 'default' , "%!v:lua.StatusLineFunc()"},
  -- { 'medium'  , sl_file .. sl_git_branch .. sl_session .. "%m%=" .. sl_lsp_status .. sl_filepath },
  { 'large'   , sl_file .. sl_git_branch .. sl_session .. "%m%=" .. sl_lsp_status .. "[%l,%c,%p%%]" .. sl_filepath },
}

vim.g.my_titlestring = {
  [ 'default' ]   = "%f",
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
  [ 'hl'     ] = { 'bg', 'Search' },
  [ 'hl+'    ] = { 'bg', 'Search' },
  -- [ 'border' ] = { 'bg', 'Ignore' },
}
vim.g.fzf_layout = {
  [ 'window' ] = { width = 0.9, height = 0.9, border = "sharp" } --, border = 'no' }
}

-- {{{
-- `Colors`   |  `fzf#vim#colors([spec dict], [fullscreen bool])`
-- vim.g.fzf_vim.colors_options = {'--style', 'full', '--border-label', ' Open Buffers ', '--preview'}
-- }}}
-- {{{
-- vim.g.status_line_lists = {
--   [ 'default' ] = { "%t %r" , sl_session, "%m%=" ,    sl_lsp_status, sl_filepath },
--   [ 'small'   ] = { "%t %r" , "%m", sl_lsp_status },
--   [ 'large'   ] = { "%t %r" , sl_session , "%m%=" ,    sl_lsp_status, sl_filepath, "[%l,%c,%p%%]" },
-- }
-- { 'default' , "%t %r %m%=" .. lsp_status, filepath, ""             },
-- { 'small'   , '%t %r %m'   .. "[%#HLspStatus#%{LspStatus()} %*]"                 },
-- { 'large'   , "%t %r %m%=" .. lsp_status, filepath, "[%l,%c,%p%%]" },
-- { 'large'  , '%t %r %m' .. '[%#HLspStatus#%{LspStatus()} %*][%l %c%V% %P]'  },
-- '[%{LspStatus()}]\\ [%f] [%h%w%m%r%=%-14.(%l,%c%V%)\\ %P]',
-- }}}
