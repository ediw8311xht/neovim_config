
-------------------------
-- Help File ------------
-------------------------

local vauto = vim.api.nvim_create_autocmd
local pattern_a = "'\\l{2,}'"
local pattern_b = "[|]\\zs\\S+\\ze[|]"
local combined  = pattern_a .. "|" .. pattern_b
local bindings_help_buffer={
    [ "CR"   ] = "<C-]>",
    [ "BS"   ] = "<C-T>",
    [ "o"    ] = "/\\v(" .. combined .. ")<CR>",
    [ "O"    ] = "?\\v(" .. combined .. ")<CR>",
    [ "<CR>" ] = "<C-]>",
    [ "<BS>" ] = "<C-T>",
}

for key,bind in pairs(bindings_help_buffer) do
  vim.keymap.set( "n", key, bind, { remap = false, buffer = true } )
end
-- vauto({"FileType"}, {
--   pattern = "help",
--   callback = function()
--   end
-- })

-- autocmd FileType help nnoremap <buffer> <CR> <C-]>
-- autocmd FileType help nnoremap <buffer> <BS> <C-T>

