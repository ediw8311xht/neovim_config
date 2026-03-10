
-- Useful guide to treesitter querying in nvim
-- https://jhcha.app/blog/the-power-of-treesitter/
-- local ts_utils = require("nvim-treesitter.ts_utils")
local ts = vim.treesitter
local vfn = vim.fn
local vapi = vim.api

local M = {
  comment_nodes = { "comment", "comment_content" },
  function_nodes = TableSetDefault({
    ["lua"]        = "((function_declaration) @func_decl)",
    ["lisp"]       = "((defun)                @func_decl)",
    ["commonlisp"] = "((defun)                @func_decl)",
  },  "((function_definition)  @func_decl)")
}


function M.Init()
  M.br = vapi.nvim_get_current_buf()
  M.ft = vapi.nvim_get_option_value("ft", { buf = M.br })
  M.lang = ts.language.get_lang(M.ft)
  M.hle = require("vim.treesitter.highlighter")
  M.tree = ts.get_parser():parse()[1]
  M.comments = M.comments or {}
  M.comments[vim.fn.bufnr()] = M.comments[vim.fn.bufnr()] or TableSetDefault({}, 0)
end

--[[
---------------- Helpers -----------------------
--]]
function M.check_node_type(node, types)
  local type = node:type()
  for _,c_type in ipairs(types) do
    if c_type == type then
      return true
    end
  end
  return false
end

function M.FirstNode(line_number)
  local s_column = vfn.match(vfn.getline(line_number), '\\S')
  if s_column < 0 then s_column=0 end
  return ts.get_node({bufnr = vfn.bufnr(), pos = {line_number-1, s_column}})
end

function M.Less(p1, p2)      return (p1[1]  < p2[1]) end
function M.LessEqual(p1, p2) return (p1[1] <= p2[1]) end
function M.Equal(p1, p2)     return (p1[1] == p2[1]) end

function M.IsInner(cpos, spos, epos)
  return M.LessEqual(spos, cpos) and M.LessEqual(cpos, epos)
end

function M.more_than_one_line(node)
  local range = node:range()
  return range[4] > range[2]
end

function M.SetCursorPos(pos)
  return vapi.nvim_win_set_cursor(0, pos)
end

--[[
---------------- Go to Query -------------------
--]]
function M.GoToQuery(query, args)
  ------------- Set options -------------
  local goto_end = args.goto_end or false
  local reverse  = args.reverse  or false
  local inner    = args.inner    or false
  ---------------------------------------

  local cpos_row, cpos_col = unpack(vapi.nvim_win_get_cursor(0))
  local cpos = {cpos_row, cpos_col}
  local iter_range = reverse and {0, cpos_row-1} or {cpos_row-1, vfn.line('$')-1}
  local new_pos

  local parsed_query = ts.query.parse(M.lang, query)

  -- Treesitter uses 0 indexed row and nvim uses 1 indexed
  for _, node, _ in parsed_query:iter_captures(M.tree:root(), 0, iter_range[1], iter_range[2]) do
    local node_start_row, node_start_col, node_end_row, node_end_col = node:range()
    local node_start = {node_start_row+1, node_start_col}
    local node_end = {node_end_row+1, node_end_col}

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
  M.Init()
  M.GoToQuery(M.function_nodes[M.ft], args or {})
end

--[[
---------------- Fold Comments  ----------------
--]]
function M.update_comments(buffer_number)
  for line_nr = 1, vim.fn.line('$')+1 do
    local node = M.FirstNode(line_nr)
    M.comments[buffer_number][line_nr] = M.check_node_type( node, M.comment_nodes ) and 1 or 0
  end
end

function M.fold_comments_multi()
  local line = vim.v.lnum
  local buf = vim.fn.bufnr()
  if  M.comments[buf][ line   ] == 1 and
     (M.comments[buf][ line-1 ] == 1 or M.comments[buf][ line+1 ] == 1)
  then
    return 1
  else
    return 0
  end
end

--[[ TO DO --]]
function M.fold_comments_block()
  -- local node = M.FirstNode()
end

function M.fold_comments_single()
  return M.comments[vim.fn.bufnr()][vim.v.lnum]
end

function M.fold_comments(args)
  if args[1] == "off" then
    vim.o.foldmethod = args[2] or "marker"
    return
  end
  M.Init()
  M.update_comments(vim.fn.bufnr())
  vim.o.foldmethod = "expr"
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

--[[
---------------- Commands ----------------------
--]]
function M.create_commands()
  vapi.nvim_create_user_command(
    "GotoNextFunctionStart",
    M.GoToFunction,
    { desc="Go to start of next function", nargs=0 })
  vapi.nvim_create_user_command(
    "GotoPrevFunctionStart",
    function() M.GoToFunction({reverse=true}) end,
    { desc="Go to previous function start", nargs=0 })
  vapi.nvim_create_user_command(
    "GotoNextFunctionEnd",
    function() M.GoToFunction({goto_end=true}) end,
    { desc="Go to end of next function", nargs=0 })
  vapi.nvim_create_user_command(
    "GotoInnerFunctionStart",
    function() M.GoToFunction({inner=true}) end,
    { desc="Go to the start of function cursor is currently inside", nargs=0 })
  vapi.nvim_create_user_command(
    "GotoInnerFunctionEnd",
    function() M.GoToFunction({inner=true, goto_end=true}) end,
    { desc="Go to the end of function cursor is currently inside", nargs=0 })
  vapi.nvim_create_user_command(
    "FoldComments",
    function(opts) M.fold_comments(MapSplit(opts.fargs[1], " ", {remove_empty = true})) end,
    { desc="Fold comments automatically with expr.",
      nargs = '?',
      complete = function(_, cmdline, _) -- (ArgLead, CmdLine, CursorPos)
        return string.sub(cmdline, -4) == "off"
          and { "marker", "marker", "manual",  "expr", "indent",  "syntax",  "diff", }
          or  { "single", "block", "multi", "off", }
      end })
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
-- -- print(ts.highlighter.active(vapi.nvim_get_current_buf()))
-- }}}
