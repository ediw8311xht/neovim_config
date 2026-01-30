
-- my stuff
require('variables')
require('functions')
require('mappings')
require('textobjects')
-- My own module for using treesitter to navigate stuff
require("my_treesitter_module").create_commands()
-- Configs
require('config/config_cmp')
require('config/config_lsp')
require('config/config_elixir')
require('config/config_gitsigns')
require('config/config_notify')
require('config/config_marks')
require('config/config_which_key')
require('config/config_treesitter')
require('config/config_auto_session')
-- require('config/config_conform') -- formatting
-- Rest


local fullscreen_window_toggle = {
  command_name = "ToggleFullscreen",
  namespace    = "fullscreen",
  scope        = "t",
  var          = "on",
  on = function()
    vim.t.fullscreen_state = vim.fn.winrestcmd()
    vim.cmd("vertical resize")
    vim.cmd("horizontal resize")
  end,
  off = function()
    vim.cmd("execute t:fullscreen_state")
  end
}

CreateToggle(fullscreen_window_toggle)

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<C-t>']   = require("telescope.actions.layout").toggle_preview,
        ['<C-S-t>'] = require("telescope.actions").select_tab,
      }
    }
  }
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


