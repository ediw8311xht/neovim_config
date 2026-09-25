
-- vim.api.nvim_create_autocmd({"User", "TSUpdate"
vim.g.MyTest = require("luasnip").session
-- local treesitter_textobjs = require('nvim-treesitter-textobjects')
require("nvim-treesitter").setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "latex" },

  indent = {
    enable = true,
    disable = { "lisp", "commonlisp" },
  },
  highlight = {
    enable = true,
    disable = { "zathurarc" },
  },
  incremental_selection = {
    enable = true,
  },
})

-- require("nvim-treesitter.parsers").my_commonlisp = {
--   install_info = {
--     revision = '32aee31b0caa95784769f8476d5309fd47b3fdf6',
--     url = 'https://github.com/ediw8311xht/tree-sitter-commonlisp-named-loops.git',
--     branch = "master",
--   },
--   -- maintainers = { "@ediw8311xht" },
--   -- files = { "src/parser.c" },
-- }

vim.treesitter.language.register("commonlisp", {"commonlisp", "lisp"})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },

  callback = function(ev)
    if not vim.g.treesitter_disable[ev.match] then
      pcall(vim.treesitter.start)
      if vim.g.treesitter_with_vim_regex_highlighting[ev.match] then
        vim.bo[ev.buf].syntax = "ON"
      end
    end
  end,
})
