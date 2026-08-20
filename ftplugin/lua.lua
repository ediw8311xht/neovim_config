
vim.opt_local.keywordprg=':help'
vim.opt_local.tabstop=2
vim.opt_local.shiftwidth=2
vim.opt_local.softtabstop=2
vim.opt_local.expandtab=true

local lua_leader_mappings = {
  n = { Ss = { desc = "[source vim]", default=CMD.source, }, },
}
KeyMapSetter2(lua_leader_mappings, "<leader>", true, true)
