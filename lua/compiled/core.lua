-- [nfnl] fnl/core.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local function setup()
  print("HI")
  return vim.keymap.set("n", "<leader>AB", ":tabnew <CR>", {desc = "newtab", noremap = true})
end
return setup
