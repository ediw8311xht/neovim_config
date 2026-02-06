
require('telescope').setup({
  -- pickers = {
  --   buffers = {
  --   },
  -- },
  defaults = {
    color_devicons = false,
    disable_devicons = true,
    dynamic_preview_title = true,
    disable_coordinates = true,
    path_display = { "smart", "truncate" },
    multi_icon = "",
    mappings = {
      i = {
        ['<C-t>']   = require("telescope.actions.layout").toggle_preview,
        ['<C-S-t>'] = require("telescope.actions").select_tab,
      }
    }
  }
})
