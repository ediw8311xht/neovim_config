
-- my stuff
require('autocmd')
require('variables')
require('functions')
require('mappings')
require('textobjects')
-- My own module for using treesitter to navigate stuff
require("my_treesitter_module").create_commands()
require('config/config_cmp')
require('config/config_lsp')
require('config/config_elixir')
require('config/config_gitsigns')
require('config/config_notify')
require('config/config_marks')
require('config/config_which_key')
require('config/config_treesitter')
-- Rest
local auto_session  = require('auto-session')

require('telescope').setup({})
auto_session.setup({
  auto_delete_empty_sessions = true,
  auto_restore = false,
  auto_save = false,
  suppressed_dirs = { "${HOME}/", "${HOME}/bin/" },
})



require('rainbow-delimiters.setup').setup {
    strategy = {
        [''] = 'rainbow-delimiters.strategy.global',
        vim = 'rainbow-delimiters.strategy.local',
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiter1',
        'RainbowDelimiter2',
        'RainbowDelimiter3',
        'RainbowDelimiter4',
        'RainbowDelimiter5',
        'RainbowDelimiter6',
        'RainbowDelimiter7',
    },
}


