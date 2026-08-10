
require('gitsigns').setup({
  signs = {
    add        = { text = '' },
    change     = { text = '' },
    delete     = { text = '_' },
    topdelete  = { text = '‾' },
    changedelete = { text = '~' },
    untracked  = { text = '┆' },
  },
  signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
  numhl    = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl   = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame_opts = {
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = true,
    virt_text_priority = 100,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = function(status)
    local head = status.head
    if head then
      return Printf("%s +%s ~%s -%s", head, status.added or 0, status.changed or 0, status.removed or 0)
    else
      return ""
    end
  end,
  -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  -- config_preview = {
  --   -- Options passed to nvim_open_win
  --   border = 'single',
  --   style = 'minimal',
  --   relative = 'cursor',
  --   row = 0,
  --   col = 1
  -- }

})

-- ffffffff 9a0s9jf
-- FFFFF 9asfasf0
