
"<==============================================================================>
"<==------------------======================================------------------==>
"<==-----    ||||-----======================================-----    ||||-----==>
"<==-----    ||||-----==__________________________________==-----    ||||-----==>
"<==-    ||||||||||||-==                                  ==-    ||||||||||||-==>
"<==-    ||||||||||||-== Nvim Config - Maximilian Ballard ==-    ||||||||||||-==>
"<==-----    ||||-----==__________________________________==-----    ||||-----==>
"<==-----    ||||-----==                                  ==-----    ||||-----==>
"<==-----    ||||-----======================================-----    ||||-----==>
"<==-----    ||||-----======================================-----    ||||-----==>
"<==------------------======================================------------------==>
"<==============================================================================>
"<==============================================================================>

source $XDG_CONFIG_HOME/nvim/vim/settings.vim
source $XDG_CONFIG_HOME/nvim/vim/slimv_settings.vim
source $XDG_CONFIG_HOME/nvim/vim/plugins.vim
source $XDG_CONFIG_HOME/nvim/vim/functions.vim

lua require('base')

"                                   #-IGNORE-#
"lua require('cmp_config')          #-IGNORE-#
"lua require('lsp_configs')         #-IGNORE-#
"lua require('my_elixir')           #-IGNORE-#
"lua require('gitsigns_config')     #-IGNORE-#
"lua require('notify_config')       #-IGNORE-#
"lua require('mappings')            #-IGNORE-#
"lua require('textobjects')         #-IGNORE-#
"                                   #-IGNORE-#
"lua require('config_treesitter')   #-IGNORE-#

call nvim_set_option("statusline", g:my_statuslines[0][1])
colorscheme pop-punk
lua CorrectColors()
