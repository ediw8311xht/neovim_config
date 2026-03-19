-- [nfnl] fnl/core.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local which_key = require("which-key")
local mod = {}
mod.register_binding = function(_2_, _3_)
  local mode = _2_.mode
  local key = _2_.key
  local typet = _3_.typet
  local value = _3_.value
  local desc = _3_.desc
  local remap = _3_.remap
  local expr = _3_.expr
  local with_which_key = _3_.with_which_key
  local with_leader = _3_.with_leader
  local with_leader0 = (with_leader == true)
  local remap0 = (remap == true)
  local typet0 = (typet or "normal")
  local key0 = ((with_leader0 and ("," .. key)) or key)
  local value0 = value
  do
    local case_4_ = string.lower(typet0)
    if (case_4_ == "cmd") then
      value0 = ("<CMD>" .. value0 .. "<CR>")
    elseif (case_4_ == "vim_command") then
      value0 = (":" .. value0 .. "<CR>")
    elseif (case_4_ == "vim_function") then
      value0 = (":call " .. value0 .. "<CR>")
    elseif (case_4_ == "lua") then
      value0 = (":lua " .. value0 .. "<CR>")
    elseif (case_4_ == "normal") then
    else
    end
  end
  vim.keymap.set(mode, key0, value0, {desc = desc, remap = remap0, expr = expr})
  if (which_key and with_which_key) then
    return which_key.add({key0, desc = desc, mode = mode})
  else
    return nil
  end
end
mod.register_binding_multiple = function(base_table)
  for mode, sub_table in pairs(base_table) do
    for key, mapping in pairs(sub_table) do
      mod.register_binding({key = key, mode = mode}, mapping)
    end
  end
  return nil
end
REGULAR_MAPPINGS = {[""] = {["+"] = {desc = "End of line", value = "g_", remap = true}, [","] = {desc = "<leader>", value = "<leader>", remap = true}, [",;"] = {desc = "", value = ","}, x = {desc = "", value = "\"xx"}}, c = {["<C-S-k>"] = {desc = "", value = "<C-c>D<C-c>"}}, i = {["<C-S-b>"] = {desc = "Backward whole word", value = "<C-o>B"}, ["<C-S-f>"] = {desc = "Forward whole word", value = "<C-o>W"}, ["<C-S-g>"] = {desc = "New undo point", value = "<C-g>u"}, ["<C-S-k>"] = {desc = "Delete to end of line", value = "<C-g>u<C-o>D"}, ["<C-S-t>"] = {desc = "Remove indent", value = "<C-d>"}, ["<C-S-u>a"] = {desc = "New undo point", value = "<C-g>u"}, ["<C-S-u>r"] = {desc = "Redo", value = "<C-o><C-r>"}, ["<C-S-u>u"] = {desc = "Undo", value = "<C-o>u"}, ["<C-u>"] = {desc = "Del entered chars b4 curs", value = "<C-g>u<C-u>"}, jk = {desc = "Exit Insert[m ]", value = "<ESC>"}}, n = {["/"] = {desc = "Search vmagic", value = "/\\v\\c"}, ["<C-S-E>"] = {desc = "End of previous word", value = "ge"}, ["<C-S-H>"] = {desc = "Left pane", value = "<C-w>h"}, ["<C-S-J>"] = {desc = "Down pane", value = "<C-w>j"}, ["<C-S-K>"] = {desc = "Up Pane", value = "<C-w>k"}, ["<C-S-L>"] = {desc = "Right pane", value = "<C-w>l"}, ["<C-S-Tab>"] = {desc = "Previous tab", value = "tabprevious", typet = "vim_command"}, ["<C-S-g>"] = {desc = "! Floating Term", value = ":FloatermToggle!<ESC>"}, ["<C-S-s>"] = {desc = "Substitute +char +vmagic", value = ":%s/\\v"}, ["<C-Tab>"] = {desc = "Next tab", value = "tabnext", typet = "vim_command"}, ["<C-n>"] = {desc = "+Nerd Tree", value = "NERDTreeToggle", typet = "vim_command"}, ["<C-s>"] = {desc = "Substitute i", value = ":%s/\\v\\c"}, ["<C-w>n"] = {desc = "New Buffer Right", value = ":new<ESC><C-w>L"}, ["<ESC>"] = {desc = "Clear", value = ":noh<ESC>:echon \"\"<enter>"}, ["?"] = {desc = "Search +back +vmagic", value = "?\\v\\c"}, ZC = {desc = "Delete Buffer", value = "bd", typet = "vim_command"}, ZG = {desc = "Write quit all", value = "wqall", typet = "vim_command"}, ["`"] = {desc = "Fold", value = "@=(foldlevel('.')?'za':\"<Space>\")<CR>"}, gne = {desc = "Next Function End", value = "GotoNextFunctionEnd", typet = "vim_command"}, ["{"] = {desc = "Prev Function Start", value = "GotoPrevFunctionStart", typet = "vim_command"}, ["|"] = {desc = "Search nomagic", value = "/\\V\\c"}, ["}"] = {desc = "Next Function Start", value = "GotoNextFunctionStart", typet = "vim_command"}}, t = {["<C-S-g>"] = {desc = "! Floating Term", value = "<C-w>:FloatermToggle!<ESC>", remap = true}, ["<C-w>"] = {desc = "Normal Mode", value = "<C-\\><C-n>", remap = true}}, v = {["<C-S-s>"] = {desc = "Sub +vmagic", value = ":s/\\%V\\v"}, ["<C-s>"] = {desc = "Sub +i +vmagic", value = ":s/\\%V\\v\\c"}, ["`"] = {desc = "", value = "zf"}}, [{"c", "i"}] = {["<C-a>"] = {desc = "Start of line", value = "<home>"}, ["<C-b>"] = {desc = "Backward char", value = "<left>"}, ["<C-e>"] = {desc = "End of line", value = "<end>"}, ["<C-f>"] = {desc = "Forward char", value = "<right>"}, ["<C-w>"] = {desc = "Forward word", value = "<S-right>"}, ["<C-S-w>"] = {desc = "Backward word", value = "<S-left>"}, ["<C-BS>"] = {desc = "Delete word backwards", value = "<C-w>"}}, [{"n", "v", "t", "i"}] = {["<C-1>"] = {desc = "Go to tab 1", value = "1gt"}, ["<C-2>"] = {desc = "Go to tab 2", value = "2gt"}, ["<C-3>"] = {desc = "Go to tab 3", value = "3gt"}, ["<C-4>"] = {desc = "Go to tab 4", value = "4gt"}, ["<C-5>"] = {desc = "Go to tab 5", value = "5gt"}, ["<C-6>"] = {desc = "Go to tab 6", value = "6gt"}, ["<C-7>"] = {desc = "Go to tab 7", value = "7gt"}, ["<C-8>"] = {desc = "Go to tab 8", value = "8gt"}, ["<C-9>"] = {desc = "Go to last tab", value = "tablast", typet = "vim_command"}}}
mod.register_binding_multiple(REGULAR_MAPPINGS)
return mod
