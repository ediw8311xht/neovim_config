vim.g.my_quickfix_mappings = {
  [""] = {
    ["<Enter>"] = { desc = "", default = "<Enter>", remap = true },
  },
}

KeyMapSetter2(vim.g.my_quickfix_mappings, "", true, true)
