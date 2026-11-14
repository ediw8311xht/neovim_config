
vim.g.formatterpath              = { "/usr/bin/" }

-- bash
vim.g.formatters_bash            = { "shfmt" }

-- fnl
vim.g.formatdef_fnlfmt           = "'fnlfmt -'"
vim.g.formatters_fennel          = { "fnlfmt" }

-- markdown
vim.g.formatdef_pandoc_format    = string.format("'%s'", FS.joinpath(vim.g.dir_config, "/scripts/pandoc_format.sh"))
vim.g.formatters_markdown        = { "pandoc_format" }

-- lua
vim.g.formatdef_stylua           = "'stylua -'"
vim.g.formatters_lua             = { "stylua" }

-- html
vim.g.formatdef_html            = { "tidy_html" }
