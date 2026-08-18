
require("helper_functions")

-- [[ gui funcs {{{ 
--]]

local original_floating_preview = vim.lsp.util.open_floating_preview
--- floating preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  local n_opts = TableDifference(vim.g.my_floating_preview_options, opts)
  return original_floating_preview(contents, syntax, n_opts, ...)
end

--- Treesitter status
function MyTreesitterStatus()
  return TS.highlighter.active[FN.bufnr()] ~= nil
end

--- AutoSession status
function AutoSessionGetCurrentName()
  return require("auto-session.lib").current_session_name(true)
end

-- local sl_filepath   = " %F "
---Status line
function StatusLineFunc()
  local sl_file = "%#StatusLine_File#" .. " %{expand('%:p:h:t')}/%t %r" .. "%*"
  local sl_git_status = "%#StatusLine_Git#" .. " %{get(b:, 'gitsigns_status', '')} " .. "%*"
  local sl_session = "%#StatusLine_Session#" .. " %{v:lua.AutoSessionGetCurrentName()} " .. "%*"
  local sl_lsp_status = "%#StatusLine_Lsp#" .. " %{v:lua.LspStatus()} " .. "%*"
  if vim.g.statusline_winid == FN.win_getid() then
    return Printf("%s%s%s%s%s", sl_file, sl_git_status, sl_session, "%m%=", sl_lsp_status)
  else
    return Printf("%s[%s][%s]%s%s", sl_file, sl_git_status, sl_session, "%m%=", sl_lsp_status)
  end
end

---Title String
function TitleStringFunc()
  local session_name = AutoSessionGetCurrentName()
  if session_name ~= "" then
    return "[session] " .. session_name
  else
    return "[nvim] " .. FN.expand("%f")
  end
end

---Tab Line
function TabLineFunc()
  local active_tab_page = API.nvim_tabpage_get_number(0)
  local function tab_calc(accum, v)
    if v == active_tab_page then
      return table.concat( { accum,
        '%#CursorLineNr#', '#',
        '%#Normal#', v,
        '%#CursorLineNr#', ' ',
        '%', v, 'T', ' ',
        '%#Keyword#', '    ', vim.fs.basename(TabBufName(v)),
        '%#Comment#', '    ',
      })
    else
      return table.concat( { accum,
        '%#Special#', '#',
        '%#Normal#', v,
        '%#Special#', ' ',
        '%', v, 'T', ' ',
        '%#Normal#', '    ', vim.fs.basename(TabBufName(v)),
        '%#Comment#', '    ',
      })
    end
  end
  return Reduce( FN.range(1, FN.tabpagenr('$')), tab_calc, "")
end
-- }}}

function ClipBoardExit()
  if EnvVarCheck("DISPLAY") and FN.executable("xclip") then
    FN.system("xclip -selection clipboard -i -r <<< ", FN.shellescape(FN.getreg("")))
  end
end

function Cycle(check_var, list, func)
  local o = API.nvim_get_option_value(check_var, {})
  func = func or function(l)
    API.nvim_set_option_value(check_var, l[2], { scope = "global" })
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


---custom highlighting settings
---runs highlight settings from vim.g.my_highlight with a few additional rules
function CorrectColors()
  local function set_highlight_from_table(hl_group, hl_table)
    return CMD.highlight(
      Reduce(
        hl_table,
        function(accum, v, k)
          return accum .. " " .. k .. "=" .. v
        end,
        hl_group
      )
    )
  end
  local function recursion_set(hl_group, hl_table)
    local _, test_v = next(hl_table)
    if type(test_v) == "string" then
      return set_highlight_from_table(hl_group, hl_table)
    end

    for c, v in pairs(hl_table) do
      if type(v) == "string" then
        CMD.highlight(Printf("%s%s %s", hl_group, c, v))
      else
        recursion_set(hl_group .. c, v)
      end
    end
  end
  CMD("hi clear @lsp.mod")
  API.nvim_set_option_value("winhighlight", "NormalNC:WindowInactive", { scope = "global" })
  recursion_set("", vim.g.my_highlight)
end

---toggle a highlight group
---toggle value is kept in vim.g.toggle_value__<highlight_group>
function ToggleHighlight(highlights)
  local seton = IsEmpty(API.nvim_get_hl(0, { name = highlights[1] }))
  for _, c in pairs(highlights) do
    if seton then
      if FN.exists("g:toggle_value__" .. c) == 0 then
        vim.notify(Printf("Variable, toggle_value__%s, doesn't exist.", c), vim.log.levels.ERROR, {
          title = "ToggeHighlight(highlights)",
        })
      else
        API.nvim_set_hl(0, c, API.nvim_get_var("toggle_value__" .. c))
      end
    else
      API.nvim_set_var("toggle_value__" .. c, API.nvim_get_hl(0, { name = highlights[1] }))
      API.nvim_set_hl(0, c, {})
    end
  end
end

function KeyMapSetter(map, pre, buffer_only, with_which_key)
  local which_key = require("which-key")
  for mode, mode_map in pairs(map) do
    for key, tbl in pairs(mode_map) do
      if tbl.group then
        which_key.add({ pre .. key, group = tbl.group, mode = mode })
        goto continue
      end
      local remap = tbl.remap or tbl[1]
      local desc = tbl.desc or tbl[2]
      local command = tbl.command or tbl[3]
      local expr = tbl.expr
      local keymap_cmd
      if with_which_key then
        which_key.add({ pre .. key, desc = desc, mode = mode })
      end
      if tbl.cmd then
        -- doesn't change modes *:map-cmd* / *<CMD>*
        keymap_cmd = "<CMD>" .. command .. "<CR>"
      elseif tbl.vim_call then
        keymap_cmd = (tbl.print and ":echo " or ":call ") .. command .. "<CR>"
      elseif tbl.lua_call then
        keymap_cmd = (tbl.print and ":lua= " or ":lua ") .. command .. "<CR>"
      else
        keymap_cmd = command
      end
      -- local keymap_cmd = (tbl.cmd and "<CMD>" .. command .. "<CR>") or command
      vim.keymap.set(mode, pre .. key, keymap_cmd, {
        remap = remap,
        desc = desc,
        buffer = buffer_only,
        expr = expr,
      })
      ::continue::
    end
  end
end

function KeyMapSetter2(map, pre, buffer_only, with_which_key)
  local function handle_command(tbl, key)
    if tbl.cmd then
      -- doesn't change modes *:map-cmd* / *<CMD>*
      return "<CMD>" .. tbl.cmd .. "<CR>"
    elseif tbl.vim_call then
      return (tbl.print and ":echo " or ":call ") .. tbl.vim_call .. "<CR>"
    elseif tbl.lua_call then
      return (tbl.print and ":lua= " or ":lua ") .. tbl.lua_call .. "<CR>"
    elseif tbl.default then
      return tbl.default
    else
      error(Printf("command not set on table: %s = %s", (key or ""), tbl))
    end
  end
  local which_key = require("which-key")
  for mode, mode_map in pairs(map) do
    for key, tbl in pairs(mode_map) do
      if tbl.group then
        which_key.add({ pre .. key, group = tbl.group, mode = mode })
        goto continue
      end
      local command = handle_command(tbl, key)
      local desc = tbl.desc
      local expr = tbl.expr
      local nowait = tbl.nowait
      local remap = tbl.remap
      local silent = tbl.silent
      if with_which_key then
        which_key.add({ pre .. key, desc = desc, mode = mode })
      end
      -- local keymap_cmd = (tbl.cmd and "<CMD>" .. command .. "<CR>") or command
      vim.keymap.set(mode, pre .. key, command, {
        buffer = buffer_only,
        desc = desc,
        expr = expr,
        nowait = nowait,
        remap = remap,
        silent = silent,
      })
      ::continue::
    end
  end
end

---highlight symbol
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
---@param options { namespace    : string,
---                 scope        : string,
---                 description  : string,
---                 command_name : string,
---                 var?         : string|(fun(): boolean),
---                 on           : function,
---                 off          : function  }
---@return function|nil
function CreateToggle(options)
  local namespace         = options.namespace or "CreateToggle__"
  local scope             = options.scope or "g"
  local description       = options.description or ""
  local command_name      = options.command_name
  local var               = options.var or command_name
  local on_function       = options.on
  local off_function      = options.off
  if type(var) ~= "function" then
    local cvar = namespace .. (options.var or command_name or "temp")
    vim[scope][cvar] = false
    var = function()
      vim[scope][cvar] = not vim[scope][cvar]
      return vim[scope][cvar]
    end
  end

  local callback_function = function()
    if var() then
      print(on_function())
    else
      print(off_function())
    end
  end
  if command_name then
    API.nvim_create_user_command(command_name, callback_function, { nargs = 0, desc = description })
    return nil
  else
    return callback_function
  end
end

---Run function and keep cursor position
---@param func function Function to run
function RunKeepCursorPosition(func)
  local last_cursor_position = API.nvim_win_get_cursor(0)
  func()
  API.nvim_win_set_cursor(0, last_cursor_position)
end

---Check if path to file exists and is writable
---@param path string Path to check
---@return boolean
function PathValid(path)
  local match = string.match(path, "^(.*[/])[^/]*$")
  print(match)
  return FN.filewritable(match) == 2
end

--Get highlight under cursor
function GetHL()
  if not pcall(vim.show_pos) then
    local synid = FN.synID(FN.line("."), FN.col("."), 1)
    if synid ~= 0 then
      print(FN.synIDattr(FN.synIDtrans(synid), "name"))
    else
      pcall(CMD.Inspect)
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
    CMD(Printf("keepalt %dread %s", opts.line, input_file))
    CMD.write({ mods = { silent = true } })
    if opts.chmod then
      CMD["!"]("chmod", opts.chmod, output_file)
      -- os.execute(printf("chmod %s '%s'", opts.chmod, output_file))
    end
  end
end

function LspStatus()
  if #vim.lsp.get_clients({ bufnr = FN.bufnr() }) > 0 then
    return require("lsp-status").status()
  else
    return ""
  end
end

---get part of file path
---@param options? {
---               tilde_home: boolean,
---               expand: string,
---               }
---@return string
function GetFile(options)
  local opts = TableDifference({ tilde_home = false, expand = "%" }, (options or {}), false)
  local file = FN.expand(opts.expand)
  if opts.tilde_home then
    return FN.substitute(file, "\\V" .. HOME, "~", "")
  else
    return file
  end
end

---Get extension of file
---@param filename? string
---@param options? {
---               glob: boolean,
---               }
---@return string
function GetExtension(filename, options)
  local glob = options and options.glob
  if glob or not filename then
    return FN.expand((filename or "%") .. ":e")
  else
    return filename:match("([^.]+$)$")
  end
end

---print all mappings
---@param file? string filename to output mappings to
function GetMappings(file)
  local out_file = file or FN.tempname()
  CMD.redir({ "> ", out_file })
  CMD.imap({ mods = { silent = true } })
  CMD.tmap({ mods = { silent = true } })
  CMD.nmap({ mods = { silent = true } })
  CMD.vmap({ mods = { silent = true } })
  CMD.redir({ "end" })
  CMD.edit({ out_file })
end

---get visual selection when :'<,'> just won't cut it
function GetVisualSelection()
  vim.g.region_post = FN.getregionpos(FN.getpos("v"), FN.getpos("."))
  local col = ""
  for _, i in ipairs(vim.g.region_post) do
    col = col .. table.concat(FN.getregion(i[1], i[2]), "\n") .. "\n"
  end
  return col
end

---get full path correctly formatted as a string for use with require
---@param table_or_string string|string[]
---@return string|string,integer
function MakeForRequire(table_or_string)
  ---@diagnostic disable-next-line: param-type-mismatch
  local string = type(table_or_string) == "string" and table_or_string or table.concat(table_or_string, "/")
  local full_path = string:gsub("[/]+", "/")

  -- return full_path:gsub("^(.*).lua$", "f")
  return full_path:gsub("^(.*).lua$", function(x)
    return x:gsub("[/]", ".")
  end)
  -- return a
end

---get buffer number by name
---@param name string
---@return integer|nil @buffer number or nil if matching buffer not found
function GetBufByName(name)
  for _, i in ipairs(API.nvim_list_bufs()) do
    if API.nvim_buf_get_name(i) == name then
      return i
    end
  end
  return nil
end

---browse buffers with file extension
---@param ext? string
---@return nil
function FZFBuffersWithExtension(ext)
  local buffers = {}
  ---@diagnostic disable-next-line: redefined-local
  local ext = ext or GetExtension("%", { glob = true })
  for _, bufnr in ipairs(API.nvim_list_bufs()) do
    if API.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
      local buf_ext = GetExtension("#" .. bufnr, { glob = true })
      if buf_ext == ext then
        table.insert(buffers, API.nvim_buf_get_name(bufnr))
      end
    end
  end
  -- FN['fzf#vim#buffers']("", buffers, FN['fzf#vim#with_preview']())
end

function IsFloating(win_id)
  return API.nvim_win_get_config(win_id or 0).zindex
end

---View or Hide floating window by buffer number or buffer name
---@param buf integer|string
---@param enter? boolean
---@param options? table
function FloatingWindowToggle(buf, enter, options)
  local buffer
  if type(buf) == "string" then
    buffer = FN.bufnr(buf)
    if not buffer then
      PrintPrintf("Couldn't find buffer matching: '%s'", buffer)
      return nil
    end
  else
    buffer = buf
  end
  --[[ HIDE --]]
  for _, v in pairs(FN.win_findbuf(buffer)) do
    if IsFloating(v) then
      return API.nvim_win_hide(v)
    end
  end
  --[[ SHOW --]]
  local window_width = API.nvim_win_get_width(0)
  local width = math.floor(window_width / 3)
  local height = math.floor(API.nvim_win_get_height(0) / 1.5)
  local default_opts = {
    anchor = "NE",
    relative = "editor",
    border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
    -- position
    col = window_width - 1,
    row = 1,
    -- size
    width = width,
    height = height,
  }
  local opts = TableDifference(default_opts, options or {}, false)
  local out_window = API.nvim_open_win(buffer or 0, enter or false, opts)
  -- prevents buffer from changing in floating window (very annoying)
  -- API.nvim_win_set_option(out_window, 'winfixbuf', true)
  return out_window
end

--- @param script string
--- @param opts? { path: string, after: function }
--- @vararg any
function ExecuteScript(script, opts, ...)
  local options = opts or {}
  local after = options.after or vim.print
  local path = options.path or vim.g.dir_scripts
  if not path and not FN.isdirectory(path) then
    error(Printf("vim.g._dir_scripts isn't set or couldn't be found. value: '%s' ", path))
  end

  local fullpath = vim.fs.joinpath(path or FN.expand("%:p:h"), script)
  vim.print(FN.filereadable(fullpath))
  if FN.filereadable(fullpath) ~= 1 then
    error(Printf("File '%s' not found", fullpath))
  end

  return vim.system({ fullpath, ... }, after)
end

function SubAllBuffers(x, y)
  local repl = Printf(':%%s/\\v\\c%s/%s', x, y)
  CMD.bufdo(
    repl
  )
end

function TabBufName(tab)
  return API.nvim_buf_get_name(API.nvim_win_get_buf(API.nvim_tabpage_get_win(tab)))
end


-- [[ do later {{{
--]]
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
--
-- API.nvim_create_user_command("BuffersWithExtension", function(opts)
--   return FZFBuffersWithExtension()
-- end, { desc = "Browse open buffers with specific extension (default current extension)", nargs = "?" })
-- command! -bang -nargs=? -complete=dir Files
--     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
-- }}}
