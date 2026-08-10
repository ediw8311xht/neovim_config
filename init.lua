
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

require("helper_functions")
require("functions")
vim.g.dir_config     = vim.fn.stdpath("config")
vim.g.dir_scripts    = vim.fs.joinpath(vim.g.dir_config, "scripts")
vim.g.dir_config_vim = vim.fs.joinpath(vim.g.dir_config, "vim")
local lua_files = { "autocmd", "variables", "my_highlight", "settings" }
local vim_files = { "settings.vim", "functions.vim" }

-- source lua files
Map(lua_files, require)
-- source vim files
Map(vim_files, function(x) SourceIf(vim.fs.joinpath(vim.g.dir_config_vim, x)) end)
-- base setup
require('plugins')
require('base')

-- color stuff
vim.cmd.colorscheme("pop-punk")
CorrectColors()

