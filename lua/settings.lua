vim.g.mapleader      = " "
vim.g.maplocalleader = ","
vim.g.python3_host_prog="/usr/bin/python"
vim.api.nvim_set_option_value("statusline"  , vim.g.my_statuslines.default , {})
vim.api.nvim_set_option_value("titlestring" , vim.g.my_titlestring.default , {})
vim.api.nvim_set_option_value("tabline"     , vim.g.my_tabline.default     , {})

vim.filetype.add({
  extension = {
    ["ex"]            = "elixir",
    ["exs"]           = "elixir",
    ["hs"]            = "haskell",
    ["kalker"]        = "kalker",
    ["lisp"]          = "lisp",
    ["page"]          = "markdown",
    ["schema"]        = "sql",
    ["scm"]           = "scheme",
    ["sh"]            = "bash",
    ["kitty-session"] = "kitty-session",
    ["md"]            = "markdown",
  },
  pattern = {
    ["${HOME}/bashrc_files/.*"]            = "bash",
    ["${XDG_CONFIG_HOME}/polybar/.*%.ini"] = "dosini",
    ["${XDG_CONFIG_HOME}/i3/.*"]           = "i3",
    ["${XDG_CONFIG_HOME}/zathura/.*"]      = "zathurarc",
  },
})

--[[  Plugin options {{{
--]]
vim.g.NERDTreeIgnore             = { "\\.o$", ".cache$", ".git$" }
vim.g.floaterm_opener            = "edit"
vim.g.html_mode                  = 1
vim.g.is_bash                    = 1
vim.g.markdown_recommended_style = 0
vim.g.vimwiki_global_ext         = 0 -- Prevent vimwiki from running on markdown not in ~/vimwiki dir.
vim.g.neoterm_automap_keys       = ",Tt"

-- vim-autoformat (:Autoformat)
vim.g.formatterpath              = { "/usr/bin/" }
vim.g.formatters_bash            = { "shfmt" }
vim.g.formatdef_fnlfmt           = "'fnlfmt -'"
vim.g.formatters_fennel          = { "fnlfmt" }
vim.g.formatdef_pandoc_format    = Printf("'%s'", FS.joinpath(vim.g.dir_config, "/scripts/pandoc_format.sh"))
vim.g.formatters_markdown        = { "pandoc_format" }

-- lf
vim.g.lf_height                  = 0.9
vim.g.lf_map_keys                = 0
vim.g.lf_width                   = 0.9
vim.g.NERDTreeHijackNetrw        = 0 -- Add this line if you use NERDTree
vim.g.lf_replace_netrw           = 1
vim.g.loaded_netrw               = 1
-- }}} 

--[[ My Settings {{{
--]]
vim.g.lsp_lang_servers = {
 'cssls',
 'bashls',
 'clangd',
 'eslint',
 'hls',
 'html',
 'jsonls',
 'lua_ls',
 'pyright',
 'tailwindcss',
 'ts_ls',
 'vimls',
 'harper',
 'harper_ls',
}
vim.g.treesitter_disable = {
  tex = true
}
vim.g.treesitter_with_vim_regex_highlighting = {
  lua = true
}
vim.g.personal_dictionary = FS.joinpath(vim.env.XDG_DATA_HOME, "dict/en_words")
-- }}}
