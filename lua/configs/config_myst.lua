
require("myst-markdown").setup({
  debug = false, -- Set true for troubleshooting
  detection = {
    scan_lines = 100,
  },
  performance = {
    cache_enabled = true,
  },
  highlighting = {
    enabled = true,
  },
})

