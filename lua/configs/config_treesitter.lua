
local treesitter = require('nvim-treesitter')
-- local treesitter_textobjs = require('nvim-treesitter-textobjects')
treesitter.setup ({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "latex", } ,

  indent = {
    enable = true,
    disable = { "lisp", "commonlisp" },
  },
  highlight = {
    enable = true,
    disable = { "zathurarc" },
  },
  incremental_selection = {
    enable = true
  },
  --[[
  If you need to change the installation directory of the parsers
  (see -> Advanced Setup) parser_install_dir = "/some/path/to/store/parsers",
  Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
  --]]
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "*" },

  callback = function(ev)
    if not vim.g.treesitter_disable[ev.match] then
      pcall(vim.treesitter.start)
      if vim.g.treesitter_with_vim_regex_highlighting[ev.match] then
        vim.bo[ev.buf].syntax = 'ON'
      end
    end
  end,
})
