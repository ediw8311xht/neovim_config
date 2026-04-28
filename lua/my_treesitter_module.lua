-- Useful guide to treesitter querying in nvim
-- https://jhcha.app/blog/the-power-of-treesitter/
-- local ts_utils = require("nvim-treesitter.ts_utils")
local ts = vim.treesitter
local fn = vim.fn
local api = vim.api
-- local setopt = vim.api.nvim_set_option_value

local function table_set_default(tbl, default)
  return setmetatable(tbl, {
    __index = function()
      return default
    end,
  })
end

local function array_to_table(array, tbl)
  for _, v in ipairs(array) do
    if tbl[v] == nil then
      tbl[v] = v
    end
  end
  return tbl
end

local M = {
  comment_nodes = { "comment", "comment_content" },
  function_nodes = table_set_default({
    ["lua"] = "((function_declaration) @func_decl)",
    ["lisp"] = "((defun) @func_decl)",
    ["commonlisp"] = "((defun) @func_decl)",
  }, "((function_definition)  @func_decl)"),
  auto_fold_augroup = nil,
  default_autofold = "multi",
  -- hle = vim.treesitter.highlighter
  fold_type = "multi",
  fold_method = table_set_default({
    single = "v:lua.require'my_treesitter_module'.fold_comments_single()",
    multi = "v:lua.require'my_treesitter_module'.fold_comments_multi()",
  }, "")
}

local state = {
  comments = table_set_default({}, table_set_default({}, 0)),
  auto_fold = table_set_default({}, {}),
  autocmd_write = nil,
  autocmd_enter = nil,
  on = false,
}

function M.update()
  local ts_parser = ts.get_parser()
  if not ts_parser then
    M.tree = nil
    M.br = api.nvim_get_current_buf()
    M.ft = api.nvim_get_option_value("ft", { buf = M.br })
    M.lang = nil
  else
    M.tree = ts_parser:parse()[1]
    M.br = api.nvim_get_current_buf()
    M.ft = api.nvim_get_option_value("ft", { buf = M.br })
    M.lang = ts.language.get_lang(M.ft)
    return true
  end
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
  if M.update() then
    return M.GoToQuery(M.function_nodes[M.ft], args or {})
  else
    return nil
  end
end

--[[
---------------- Fold Comments  ----------------
--]]
---update comments
---@param buffer_number number
function M.update_comments(buffer_number)
  M.update()
  if not M.tree then
    state.comments[buffer_number] = table_set_default({}, 0)
    return
  end

  for line_nr = 1, vim.fn.line("$") + 1 do
    local node = M.FirstNode(line_nr)
    state.comments[buffer_number][line_nr] = M.check_node_type(node, M.comment_nodes) and 1 or 0
  end
end

function M.fold_comments_multi()
  local line = vim.v.lnum
  local buf = vim.fn.bufnr()
  if state.comments[buf][line] == 1 and (state.comments[buf][line - 1] == 1 or state.comments[buf][line + 1] == 1) then
    return 1
  else
    return 0
  end
end

function M.fold_comments_single()
  return state.comments[vim.fn.bufnr()][vim.v.lnum]
end

function M.set_fold()
  if state.on then
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = M.fold_method[state.fold_type]
  else
    vim.wo.foldmethod = "manual"
    vim.wo.foldexpr = ""
  end
end
---Fold comments
function M.fold_comments(args) --, options)
  M.update()
  local a = args[1]
  if a == "off" then
    state.on = false
    M.set_fold()
  elseif a ~= "update" then
    state.on = true
    state.fold_type = a
    M.set_fold()
  end
  M.update_comments(M.br)
end

function M.auto_fold_comments(args)
  local opts = array_to_table(args, {})
  local autocmd_id = state.autocmd_write
  state.fold_type = opts.single or opts.multi or state.fold_type or M.default_autofold
  -- ensure autocmd_id is deleted
  if state.autocmd_write then
    api.nvim_del_autocmd(autocmd_id)
  end
  -- autocmd_enter handles setting foldmethod and foldexpr when state is on/off
  if not state.autocmd_enter then
    state.autocmd_enter = api.nvim_create_autocmd({ "BufEnter", "WinEnter", "SessionloadPost" }, {
      callback = function(callback_args)
        M.set_fold()
        if state.on then
          M.update_comments(callback_args.buf)
        end
      end,
    })
  end
  if opts.off or (opts.toggle and state.on) then
    state.on = false
    state.autocmd_write = nil
    M.set_fold()
  else
    state.on = true
    M.set_fold()
    M.update_comments(fn.bufnr())
    state.autocmd_write = api.nvim_create_autocmd({ "BufWrite" }, {
      callback = function(callback_args)
        M.update()
        M.update_comments(callback_args.buf)
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
      return { "off", "single", "multi" }
    end,
  })
  api.nvim_create_user_command("FoldComments", function(opts)
    M.fold_comments(MapSplit(opts.fargs[1], " ", { remove_empty = true }))
  end, {
    desc = "Fold comments automatically with expr.",
    nargs = "?",
    complete = function(_, _, _) -- (ArgLead, CmdLine, CursorPos)
      -- return string.match(cmdline, "%s+off%s+$")
      --     and { "marker", "marker", "manual", "expr", "indent", "syntax", "diff" }
        -- or { "single", "multi", "off", "on", "off", "toggle" }
        return { "single", "multi" }
    end,
  })
end

return M

-- {{{
-- function M.OnSameLine(node1, node2)
--   local sr1, sc1 = node1:range()
--   local sr2, sc2 = node2:range()
--   return sr1 == sr2
-- end
--
-- function M.Gtest()
--   local comment_query = [[
--     ((comment) @my_capture)
--   ]]
--
--   local br = vim.api.nvim_get_current_buf()
--   local ft = vim.api.nvim_get_option_value("ft", { buf = br })
--   local lang = vim.treesitter.language.get_lang(ft)
--   local hle = require("vim.treesitter.highlighter")
--
--   M.tree = ts.get_parser():parse()[1]
--   local query = ts.query.parse(lang, comment_query)
--   if not hle.active[br] then print("[CommentFold] No parser found for treesitter.") return end
--
--   for id, node, metadata in query:iter_captures(M.tree:root(), 0) do
--     local row1, col1, row2, col2 = node:range() -- range of the capture
--     print(row1, col1)
--     local prev_sibling = node:prev_sibling()
--     local next_sibling = node:next_sibling()
--     if prev_sibling:type() ~= "comment" then
--       print(M.OnSameLine(prev_sibling, node))
--       -- print("HI: ", prev_sibling:type())
--     end
--   end
--   -- local query = vim.treesitter.query.parse(lang, bnr);
--   -- ; query
--   -- ]]
--   -- )
--   -- for i in query:iter_captures(
--   -- for v=1,39 do
--   --   print(M.FirstNode(v))
--   --   print("\n")
--   -- end
--   -- print(M.FirstNode(26))
--   -- print("\n")
--   -- for id, node, metadata in query:iter_captures(M.tree:root(), 0) do
--   --   local row1, col1, row2, col2 = node:range() -- range of the capture
--   -- end
-- end
--
-- -- M.Gtest()
-- -- print(ts.highlighter.active(api.nvim_get_current_buf()))
-- }}}
