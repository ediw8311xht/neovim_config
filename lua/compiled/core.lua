-- [nfnl] fnl/core.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
vim.g.mapleader = " "
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>AA", ":tabnew", {desc = "newtab", noremap = true})
local function setup()
  print("HI")
  return vim.keymap.set("n", "<leader>AA", ":tabnew", {desc = "newtab", noremap = true})
end
return setup()
