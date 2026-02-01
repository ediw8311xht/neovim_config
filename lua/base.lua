
-- my stuff
require('variables')
require('functions')
require('mappings')
require('textobjects')
-- My own module for using treesitter to navigate stuff
require("my_treesitter_module").create_commands()
-- Configs
for _,i in ipairs(vim.fn.globpath(vim.fn.stdpath("config"), "lua/configs/*", 0, 1)) do
  require(string.match(i, "(configs/[^/]-).lua$"))
end
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


