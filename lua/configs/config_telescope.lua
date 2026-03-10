
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
    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.95,
    },
    vimgrep_arguments = {
      "rg",
      "--no-config",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    mappings = {
      i = {
        [ '<C-t>'   ] = require('telescope.actions.layout').toggle_preview,
        [ '<C-S-t>' ] = require('telescope.actions').select_tab,
        [ '<C-g>'   ] = require('telescope.actions').preview_scrolling_down,
        [ '<C-h>'   ] = require('telescope.actions').preview_scrolling_up,
        [ '<C-u>'   ] = require('telescope.actions').results_scrolling_down,
        [ '<C-d>'   ] = require('telescope.actions').results_scrolling_up,
        [ '<C-s>'   ] = require('telescope.actions').select_horizontal,
        [ '<C-v>'   ] = require('telescope.actions').select_vertical,
      }
    }
  }
})
