-- Useful guide to treesitter querying in nvim
-- https://jhcha.app/blog/the-power-of-treesitter/
-- local ts_utils = require("nvim-treesitter.ts_utils")
local ts = vim.treesitter
local fn = vim.fn
local api = vim.api

local function TableSetDefault(tbl, default)
  return setmetatable(tbl, {
    __index = function()
      return default
    end,
  })
end

local function ArrayToTable(array, tbl)
  for _, v in ipairs(array) do
    if tbl[v] == nil then
      tbl[v] = v
    end
  end
  return tbl
end

local M = {
  comment_nodes = { "comment", "comment_content" },
  comment_block_nodes = { "block_comment" },
  function_nodes = TableSetDefault({
    ["lua"]        = "((function_declaration) @func_decl)",
    ["lisp"]       = "((defun) @func_decl)",
    ["commonlisp"] = "((defun) @func_decl)",
    --- just because i like navigating tags
    ["html"]       = "((start_tag) @func_decl)",
  }, "((function_definition)  @func_decl)"),
  auto_fold_augroup = nil,
  -- hle = vim.treesitter.highlighter
}

local state = {
  comments = TableSetDefault({}, TableSetDefault({}, 0)),
  auto_fold = TableSetDefault({}, {}),
  previous_foldmethod = {},
}

function M.update()
  M.tree = ts.get_parser():parse()[1]
  M.br = api.nvim_get_current_buf()
  M.ft = api.nvim_get_option_value("ft", { buf = M.br })
  M.lang = ts.language.get_lang(M.ft)
end
--[[
---------------- Helpers -----------------------
--]]
function M.check_node_type(node, types)
  local type = node:type()
  for _, c_type in ipairs(types) do
    if c_type == type then
      return true
    end
  end
  return false
end

function M.FirstNode(line_number)
  local s_column = fn.match(fn.getline(line_number), "\\S")
  if s_column < 0 then
    s_column = 0
  end
  return ts.get_node({ bufnr = fn.bufnr(), pos = { line_number - 1, s_column } })
end

function M.Less(p1, p2)
  return (p1[1] < p2[1])
end
function M.LessEqual(p1, p2)
  return (p1[1] <= p2[1])
end
function M.Equal(p1, p2)
  return (p1[1] == p2[1])
end

function M.IsInner(cpos, spos, epos)
  return M.LessEqual(spos, cpos) and M.LessEqual(cpos, epos)
end

function M.more_than_one_line(node)
  local range = node:range()
  return range[4] > range[2]
end

function M.SetCursorPos(pos)
  return api.nvim_win_set_cursor(0, pos)
end

--[[
---------------- Go to Query -------------------
--]]
function M.GoToQuery(query, args)
  ------------- Set options -------------
  local goto_end = args.goto_end or false
  local reverse = args.reverse or false
  local inner = args.inner or false
  ---------------------------------------

  ---@diagnostic disable: deprecated yeah this is annoying....
  local cpos_row, cpos_col = unpack(api.nvim_win_get_cursor(0))
  local cpos = { cpos_row, cpos_col }
  local iter_range = reverse and { 0, cpos_row - 1 } or { cpos_row - 1, fn.line("$") - 1 }
  local new_pos

  local parsed_query = ts.query.parse(M.lang, query)

  -- Treesitter uses 0 indexed row and nvim uses 1 indexed
  for _, node, _ in parsed_query:iter_captures(M.tree:root(), 0, iter_range[1], iter_range[2]) do
    local node_start_row, node_start_col, node_end_row, node_end_col = node:range()
    local node_start = { node_start_row + 1, node_start_col }
    local node_end = { node_end_row + 1, node_end_col }

    new_pos = goto_end and node_end or node_start
    if reverse then
      goto continue
    elseif not M.IsInner(cpos, node_start, node_end) then
      return M.SetCursorPos(new_pos)
    elseif inner or M.Less(cpos, new_pos) then
      return M.SetCursorPos(new_pos)
    end
    ::continue::
  end
  return new_pos and M.SetCursorPos(new_pos)
end

function M.GoToFunction(args)
  M.update()
  M.GoToQuery(M.function_nodes[M.ft], args or {})
end

--[[
---------------- Fold Comments  ----------------
--]]
function M.update_comments(buffer_number)
  for line_nr = 1, vim.fn.line("$") + 1 do
    local node = M.FirstNode(line_nr)
    if M.check_node_type(node, M.comment_block_nodes) then
      local _,_,node_end_row,_ = node:range()
      while line_nr <= (node_end_row + 1) do
        state.comments[buffer_number][line_nr] = 2
        line_nr = line_nr + 1
      end
    elseif  M.check_node_type(node, M.comment_nodes) then
      state.comments[buffer_number][line_nr] = 1
    else
      state.comments[buffer_number][line_nr] = 0
    end
  end
end

function M.fold_comments_multi()
  local line = vim.v.lnum
  local buf = vim.fn.bufnr()
  if state.comments[buf][line] ~= 0 and (state.comments[buf][line - 1] ~= 0 or state.comments[buf][line + 1] ~= 0) then
    return 1
  else
    return 0
  end
end

function M.fold_comments_block()
  return (state.comments[vim.fn.bufnr()][vim.v.lnum] == 2)
end

function M.fold_comments_single()
  return (state.comments[vim.fn.bufnr()][vim.v.lnum] ~= 0 and 1)
end

---Fold comments
function M.fold_comments(args) --, options)
  M.update()
  local buf = M.br
  if args[1] == "off" then
    vim.o.foldmethod = state.previous_foldmethod[buf]
    return
  end
  M.update_comments(buf)
  if vim.o.foldmethod ~= "expr" then
    state.previous_foldmethod[buf] = vim.o.foldmethod
    vim.o.foldmethod = "expr"
  end
  if not args[1] or args[1] == "single" then
    vim.o.foldexpr = "v:lua.require'my_treesitter_module'.fold_comments_single()"
  elseif args[1] == "update" then
    return
  elseif args[1] == "block" then
    vim.o.foldexpr = "v:lua.require'my_treesitter_module'.fold_comments_block()"
  elseif args[1] == "multi" then
    vim.o.foldexpr = "v:lua.require'my_treesitter_module'.fold_comments_multi()"
  else
    error("invalid argument")
  end
end

function M.auto_fold_comments(args)
  local opts = ArrayToTable(args, {})
  local on_off = opts.off ~= "off"
  local buf = vim.fn.bufnr()
  local autocmd_id   = state.auto_fold[buf].id
  -- local autocmd_type = state.auto_fold[buf].type
  local type = opts.single or opts.multi or opts.block or nil
  vim.notify("AutoFoldComments turned " .. (on_off and "on" or "off"))
  if autocmd_id then
    pcall(api.nvim_del_autocmd, autocmd_id)
    state.auto_fold[buf].id = nil
  end
  if not on_off then
    M.fold_comments({ "off" })
  elseif type then
    M.fold_comments({ type })
    state.auto_fold[buf] = {type = type}
    state.auto_fold[buf].id = vim.api.nvim_create_autocmd(
      { "BufWrite" }, {
        buffer = buf,
        group = M.auto_fold_augroup,
        callback = function()
          M.fold_comments({ type })
        end,
      })
  end
end

--[[
|---------------------------------------------|
|--------------- Commands --------------------|
|---------------------------------------------|
--]]
function M.create_commands()
  api.nvim_create_user_command(
    "GotoNextFunctionStart",
    M.GoToFunction,
    { desc = "Go to start of next function", nargs = 0 }
  )
  api.nvim_create_user_command("GotoPrevFunctionStart", function()
    M.GoToFunction({ reverse = true })
  end, { desc = "Go to previous function start", nargs = 0 })
  api.nvim_create_user_command("GotoNextFunctionEnd", function()
    M.GoToFunction({ goto_end = true })
  end, { desc = "Go to end of next function", nargs = 0 })
  api.nvim_create_user_command("GotoInnerFunctionStart", function()
    M.GoToFunction({ inner = true })
  end, { desc = "Go to the start of function cursor is currently inside", nargs = 0 })
  api.nvim_create_user_command("GotoInnerFunctionEnd", function()
    M.GoToFunction({ inner = true, goto_end = true })
  end, { desc = "Go to the end of function cursor is currently inside", nargs = 0 })
  api.nvim_create_user_command("AutoFoldComments", function(opts)
    M.auto_fold_comments(MapSplit(opts.fargs[1], " ", { remove_empty = true }))
  end, {
    desc = "Auto fold comments",
    nargs = 1,
    complete = function(_, _, _)
      return { "off", "single", "multi", "block" }
    end,
  })
  api.nvim_create_user_command("FoldComments", function(opts)
    M.fold_comments(MapSplit(opts.fargs[1], " ", { remove_empty = true }))
  end, {
    desc = "Fold comments automatically with expr.",
    nargs = "?",
    complete = function(_, cmdline, _) -- (ArgLead, CmdLine, CursorPos)
      return string.match(cmdline, "%s+off%s+$")
          and { "marker", "marker", "manual", "expr", "indent", "syntax", "diff" }
        or { "single", "block", "multi", "off" }
    end,
  })
end

return M

