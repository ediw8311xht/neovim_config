
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
