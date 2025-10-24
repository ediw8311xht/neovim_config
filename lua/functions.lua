
local va    = vim.api
local vfn   = vim.fn
-- local ts    = vim.treesitter

-- local vauto = va.nvim_create_autocmd
-- local vc    = vim.cmd

function EnvVarCheck(var)
  local e = os.getenv(var)
  if e == nil or e == '' then
    return false
  else
    return e
  end
end

function ClipBoardExit()
  if EnvVarCheck("$DISPLAY") and va.executable("xclip") then
    va.system('xclip -selection clipboard -i -r <<< ', va.getreg('a'))
  end
end

function Contains(t, check_value, callback)
  if callback == nil then callback = (function(a,b) return a == b end) end
  for _,v in ipairs(t) do
    if callback(v, check_value) then
      return true
    end
  end
  return false
end

function Cycle(check_var, list, func)
  local o = va.nvim_get_option(check_var)
  if not func then
    func = (function(l) va.nvim_set_option_value(check_var, l[2], { scope = "global"}) return l[1] end)
  end
  if #list <= 0 then return end
  for i,v in ipairs(list) do
    if v[2] == o then
      return func(list[(i) % (#list)+1])
    end
  end
  return func(list[1])
end

function CorrectColors()
  local function Main(comm, hl_table)
    if #hl_table == 0 then
      for c,v in pairs(hl_table) do Main(comm .. c, v) end
    else
      vim.cmd("hi " .. comm .. " " .. table.concat(hl_table, " "))
    end
  end
  va.nvim_set_option_value( "winhighlight",
    "NormalNC:WindowInactive",
    { scope = "global" })
  Main("", vim.g.my_highlight)
end

function ToggleOne()
  if not vim.t.ToggleOne__on or not vim.t.ToggleOne__state then
    vim.t.ToggleOne__state = vfn.winrestcmd()
    vim.cmd("vertical resize")
    vim.cmd("horizontal resize")
    vim.t.ToggleOne__on = true
  else
    vim.cmd("execute t:ToggleOne__state")
    vim.t.ToggleOne__on = false
  end
end

function AutoSessionStatusLine()
  return require("auto-session.lib").current_session_name(true)
end

function GetNested(table, keys) 
  local current = table
  for i =1, #keys do
    if keys[i] == nil then
      return false
    end
    current = current[key]
  end
  return current
end
function IsEmpty(table)
  return next(table) == nil
end
function ToggleHighlight(highlights)
  local seton = IsEmpty( va.nvim_get_hl(0, { name = highlights[1] }) )
  for _,c in pairs(highlights) do
    if seton then
      if vfn.exists("g:toggle_value_"..c) == 0 then
        vim.notify("Variable, toggle_value__"..c..", doesn't exist.", "error", {
          title="ToggeHighlight(highlights)"
        })
      else
        va.nvim_set_hl(0, c, vim.api.nvim_get_var("toggle_value_"..c))
      end
    else
      va.nvim_set_var("toggle_value__"..c, va.nvim_get_hl(0, {name = highlights[1]}) )
      va.nvim_set_hl(0, c, {})
    end
  end
end



