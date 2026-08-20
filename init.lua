
--[[ <==============================================================================>
     <==------------------======================================------------------==>
     <==-----    ||||-----======================================-----    ||||-----==>
     <==-----    ||||-----==__________________________________==-----    ||||-----==>
     <==-    ||||||||||||-==                                  ==-    ||||||||||||-==>
     <==-    ||||||||||||-== Nvim Config - Maximilian Ballard ==-    ||||||||||||-==>
     <==-----    ||||-----==__________________________________==-----    ||||-----==>
     <==-----    ||||-----==                                  ==-----    ||||-----==>
     <==-----    ||||-----======================================-----    ||||-----==>
     <==-----    ||||-----======================================-----    ||||-----==>
     <==------------------======================================------------------==>
     <==============================================================================>
     <==============================================================================> --]]

--[[ neccessary for "Map" --]]
require("helper_functions")

--[[ global lua --]]
CMD  = vim.cmd
API  = vim.api
FN   = vim.fn
HOME = vim.env.HOME
FS   = vim.fs
TS   = vim.treesitter

--[[ global --]]
vim.g.dir_config     = vim.fn.stdpath("config")
vim.g.dir_scripts    = vim.fs.joinpath(vim.g.dir_config, "scripts")
vim.g.dir_config_vim = vim.fs.joinpath(vim.g.dir_config, "vim")

--[[ config files to load --]]
local lua_files = {
  "functions",
  "settings",
  "autocmd",
  "my_highlight",
}

local vim_files = {
  "settings.vim",
  "functions.vim",
}

--[[ load config files --]]
Map(lua_files, require) -- source lua files
Map(vim_files, -- source vim files
  function(x) SourceIf(vim.fs.joinpath(vim.g.dir_config_vim, x)) end)

--[[ base setup --]]
require('plugins')
require('base')
require('neovide-config')

--[[ set colorscheme and correct colors --]]
vim.cmd.colorscheme("pop-punk")
CorrectColors()

