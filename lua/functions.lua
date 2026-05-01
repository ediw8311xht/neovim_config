-- require("variables")
-- local vauto = va.nvim_create_autocmd
-- local vc    = vim.cmd
require("helper_functions")
local home   = vim.env.HOME
local api    = vim.api
local cmd    = vim.cmd
local fn     = vim.fn
local fs     = vim.fs
local printf = vim.fn.printf
local ts     = vim.treesitter

local original_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  local n_opts = TableDifference(vim.g.my_floating_preview_options, opts)
  return original_floating_preview(contents, syntax, n_opts, ...)
end

function MyTreesitterStatus()
  return ts.highlighter.active[fn.bufnr()] ~= nil
end

function AutoSessionStatusLine()
  return require("auto-session.lib").current_session_name(true)
end

function ClipBoardExit()
  if EnvVarCheck("DISPLAY") and fn.executable("xclip") then
    fn.system("xclip -selection clipboard -i -r <<< ", fn.shellescape(fn.getreg("")))
  end
end

function Cycle(check_var, list, func)
  local o = api.nvim_get_option(check_var)
  func = func or function(l)
    api.nvim_set_option_value(check_var, l[2], { scope = "global" })
    return l[1]
  end
  if #list <= 0 then
    return
  end
  for i, v in ipairs(list) do
    if v[2] == o then
      return func(list[i % #list + 1])
    end
  end
  return func(list[1])
end

function SetHighlightFromTable(hl_group, hl_table)
  local conc = "hi " .. hl_group
  for c, v in pairs(hl_table) do
    conc = conc .. " " .. c .. "=" .. v
  end
  cmd(conc)
end

function CorrectColors()
  local function Main(hl_group, hl_table)
    local _, test_v = next(hl_table)
    if type(test_v) == "string" then
      SetHighlightFromTable(hl_group, hl_table)
    else
      for c, v in pairs(hl_table) do
        Main(hl_group .. c, v)
      end
    end
  end
  cmd("hi clear @lsp.mod")
  api.nvim_set_option_value("winhighlight", "NormalNC:WindowInactive", { scope = "global" })
  Main("", vim.g.my_highlight)
end

function ToggleHighlight(highlights)
  local seton = IsEmpty(api.nvim_get_hl(0, { name = highlights[1] }))
  for _,c in pairs(highlights) do
    if seton then
      if fn.exists("g:toggle_value__" .. c) == 0 then
        vim.notify("Variable, toggle_value__" .. c .. ", doesn't exist.", "error", {
          title = "ToggeHighlight(highlights)",
        })
      else
        api.nvim_set_hl(0, c, vim.api.nvim_get_var("toggle_value__" .. c))
      end
    else
      api.nvim_set_var("toggle_value__" .. c, api.nvim_get_hl(0, { name = highlights[1] }))
      api.nvim_set_hl(0, c, {})
    end
  end
end

function KeyMapSetter(map, pre, buffer_only, with_which_key)
  local which_key = require("which-key")
  for mode, mode_map in pairs(map) do
    for key, tbl in pairs(mode_map) do
      local keymap_cmd
      if tbl.group then
        which_key.add({ pre .. key, group = tbl.group, mode = mode })
        goto continue
      end
      if with_which_key then
        which_key.add({ pre .. key, desc = tbl[2], mode = mode })
      end
      if tbl.cmd then
        -- doesn't change modes *:map-cmd* / *<CMD>*
        keymap_cmd = "<CMD>" .. tbl[3] .. "<CR>"
      elseif tbl.vim_command then
        keymap_cmd = (tbl.print and ":echo " or ":call ") .. tbl[3] .. "<CR>"
      elseif tbl.lua_call then
        keymap_cmd = (tbl.print and ":lua= " or ":lua ") .. tbl[3] .. "<CR>"
      else
        keymap_cmd = tbl[3]
      end
      -- local keymap_cmd = (tbl.cmd and "<CMD>" .. tbl[3] .. "<CR>") or tbl[3]
      vim.keymap.set(mode, pre .. key, keymap_cmd, {
        remap = tbl[1],
        desc = tbl[2],
        buffer = buffer_only,
        expr = tbl.expr,
      })
      ::continue::
    end
  end
end

function LspDocumentHighlight()
  -- local ignore_modes = { "i", "niI", "niR", "niV", "nt" }
  vim.lsp.buf.clear_references()
  -- if in vim.lsp.get_active_clients method="" filter doesn't work for some reason....
  -- oh wait they are just retards
  -- https://github.com/neovim/neovim/issues/18939
  for _, v in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if v.server_capabilities.documentHighlightProvider then
      vim.lsp.buf.document_highlight()
      return
    end
  end
end

---Create toggle command
---@param options {
---                 namespace:    string,
---                 scope:        string,
---                 description:  string,
---                 command_name: string,
---                 var:          string,
---                 on:           function,
---                 off:          function,
---               }
---
---@return function|nil
function CreateToggle(options)
  local namespace = options.namespace or "CreateToggle__"
  local scope = options.scope or "g"
  local description = options.description or ""
  local command_name = options.command_name
  local var = namespace .. (options.var or command_name or "temp")
  local on_function = options.on
  local off_function = options.off
  local callback_function = function()
    print(vim[scope][var])
    if not vim[scope][var] then
      vim[scope][var] = true
      on_function()
    else
      vim[scope][var] = false
      off_function()
    end
  end
  if command_name then
    vim.api.nvim_create_user_command(command_name, callback_function, { nargs = 0, desc = description })
    return nil
  else
    return callback_function
  end
end

---Run function and keep cursor position
---@param func function Function to run
function RunKeepCursorPosition(func)
  local last_cursor_position = vim.api.nvim_win_get_cursor(0)
  func()
  vim.api.nvim_win_set_cursor(0, last_cursor_position)
end

---Check if path to file exists and is writable
---@param path string Path to check
---@return boolean
function PathValid(path)
  local match = string.match(path, "^(.*[/])[^/]*$")
  print(match)
  return fn.filewritable(match) == 2
end

--Get highlight under cursor
function GetHL()
  if not pcall(vim.show_pos) then
    local synid = vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1)
    if synid ~= 0 then
      print(vim.fn.synIDattr(vim.fn.synIDtrans(synid), "name"))
    else
      pcall(cmd, ":Inspect")
    end
  end
end

---Write contents of input_file to output_file
---@param input_file  string
---@param output_file string
---@param options? {
---                  chmod: string,
---                  line: number,
---               }
---
function ReadInFile(input_file, output_file, options)
  -- options
  local opts = options or { line = 0, chmod = nil }
  if not PathValid(output_file) then
    error("path: '" .. output_file .. "' is invalid.")
  else
    cmd(printf("keepalt %dread %s", opts.line, input_file))
    cmd.write( { mods = { silent = true } })
    if opts.chmod then
      os.execute(printf("chmod %s %s", opts.chmod, output_file))
    end
  end
end

function LspStatus()
  if #vim.lsp.get_clients({ bufnr = vim.fn.bufnr()}) > 0 then
    return require('lsp-status').status()
  else
    return ""
  end
end

---Get part of file path
---@param options {
---               tilde_home: boolean,
---               expand: string,
---               }
---@return string
function GetFile(options)
  local opts = TableDifference({tilde_home = false, expand = "%"}, options, false)
  local file = fn.expand(opts.expand)
  if opts.tilde_home then
    return vim.fn.substitute(file, '\\V' .. home, "~", "")
  else
    return file
  end
end

---print all mappings
---@param file? string filename to output mappings to
function GetMappings(file)
  local out_file = file or fn.tempname()
  cmd.redir {"> ", out_file}
  cmd.imap  {mods  = {silent  = true}}
  cmd.tmap  {mods  = {silent  = true}}
  cmd.nmap  {mods  = {silent  = true}}
  cmd.vmap  {mods  = {silent  = true}}
  cmd.redir {"end"}
  cmd.edit  {out_file}
end


function GetVisualSelection()
  vim.g.region_post = fn.getregionpos(fn.getpos('v'), fn.getpos('.'))
  local col = ""
  for _,i in ipairs(vim.g.region_post) do
    col = col .. table.concat(fn.getregion(i[1], i[2]), '\n') .. '\n'
  end
  return col
end

---get full path correctly formatted as a string for use with require
---@param table_or_string string|string[]
function MakeForRequire(table_or_string)
  ---@diagnostic disable-next-line: param-type-mismatch
  local string = type(table_or_string) == "string" and table_or_string or table.concat(table_or_string, "/")
  local full_path  = string:gsub("[/]+", "/")

  -- return full_path:gsub("^(.*).lua$", "f")
  return full_path:gsub("^(.*).lua$", function(x)
    return x:gsub("[/]", ".")
  end)
  -- return a
end

---Get buffer number by name
---@param name string
---@return integer|nil @buffer number or nil if matching buffer not found
function GetBufByName(name)
  for _,i in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(i) == name then
      return i
    end
  end
  return nil
end

--do later---------------------------------------------------{{{
-- function GutterSign()
--   print("h")
-- end
--
-- function GutterNum()
--   print("n")
-- end

-------------------------------------------------------------
-- for id in synstack(line("."), col("."))
--    echo synIDattr(id, "name")
-- endfor
-- if l:synid != 0
--   echo synIDattr(synIDtrans(l:synid), "name")
-- else
--   :Inspect
-- end
-- function KeyMapSetter2(map, pre, buffer_only, with_which_key)
--   local which_key = require("which-key")
--   for mode, mode_map in pairs(map) do
--     for key, tbl in pairs(mode_map) do
--       local expression
--
--       if tbl.vim_function then
--         expression = "<CMD> call " .. tbl.key .. "<CR>"
--       elseif tbl.lua_function then
--         expression = "<CMD> lua " .. tbl.key .. "<CR>"
--       elseif tbl.cmd then
--         expression = "<CMD>" .. tbl.key .. "<CR>"
--       else
--         expression = tbl.key
--       end
--       if with_which_key then
--         which_key.add({ pre .. key, desc = tbl.desc, mode = mode })
--       end
--       vim.keymap.set(mode, pre .. key, expression, {
--         remap  = tbl.remap or false,
--         desc   = tbl.desc,
--         buffer = buffer_only or tbl.buffer_only,
--         expr   = tbl.expr,
--       })
--     end
--   end
-- end
-- }}}
