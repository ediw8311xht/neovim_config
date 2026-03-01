
-- Useful guide to treesitter querying in nvim
-- https://jhcha.app/blog/the-power-of-treesitter/

local ts = vim.treesitter --f
-- local ts_utils = require("nvim-treesitter.ts_utils")
local vfn = vim.fn
local vapi = vim.api

local M = {
}

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

function M.Init()
  M.br = vapi.nvim_get_current_buf()
  M.ft = vapi.nvim_get_option_value("ft", { buf = M.br })
  M.lang = ts.language.get_lang(M.ft)
  M.hle = require("vim.treesitter.highlighter")
  M.tree = ts.get_parser():parse()[1]
end

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
--[[

--]]

function M.Less(p1, p2)      return (p1[1]  < p2[1]) end -- or ( p1[1] == p2[1] and p1[2]   < p2[2] )) end
function M.LessEqual(p1, p2) return (p1[1] <= p2[1]) end -- or ( p1[1] == p2[1] and p1[2]  <= p2[2] )) end
function M.Equal(p1, p2)     return (p1[1] == p2[1]) end -- and p1[2] == p2[2]) end

function M.IsInner(cpos, spos, epos)
  return M.LessEqual(spos, cpos) and M.LessEqual(cpos, epos)
end

function M.SetCursorPos(pos)
  return vapi.nvim_win_set_cursor(0, pos)
end

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
  args = args or {}
  local func_query
  if     args and args.test   then  return M.test_g()
  elseif M.ft == "lua"        then  func_query = " ( (function_declaration) @func_decl ) "
  elseif M.ft == "lisp"       then  func_query = " ( (defun)                @func_decl ) "
  elseif M.ft == "commonlisp" then  func_query = " ( (defun)                @func_decl ) "
  else                              func_query = " ( (function_definition)  @func_decl ) "
  end
  M.GoToQuery(func_query, args)
end

function M.more_than_one_line(node)
  local range = node:range()
  print(range[4], range[2])
  return range[4] > range[2]
end

--[[ 
block to only comment out comments that are multiple lines. 
--]]

-- TO DO --
function M.fold_comments_multi(line_number)
  local max_line = vim.fn.line('$')
  local node = M.FirstNode(line_number)
end

-- TO DO --
function M.fold_comments_block(line_number)
  local node = M.FirstNode(line_number)
end

function M.fold_comments()
  print("HERE")
  local node = M.FirstNode(vim.v.lnum)
  print(vim.v.lnum)
  print(node)
  print(node:type())
  if M.check_node_type(node, { "comment", "comment_content" }) then
    print("BYE")
    return 1
  else
    return 0
  end
end

--[[
--]]

function M.create_commands()
  vapi.nvim_create_user_command(
    "GotoNextFunctionStart",
    M.GoToFunction,
    { desc="Go to start of next function", nargs=0 }
  )

  vapi.nvim_create_user_command(
    "GotoPrevFunctionStart",
    function() M.GoToFunction({reverse=true}) end,
    { desc="Go to previous function start", nargs=0 }
  )

  vapi.nvim_create_user_command(
    "GotoNextFunctionEnd",
    function() M.GoToFunction({goto_end=true}) end,
    { desc="Go to end of next function", nargs=0 }
  )

  vapi.nvim_create_user_command(
    "GotoInnerFunctionStart",
    function() M.GoToFunction({inner=true}) end,
    { desc="Go to the start of function cursor is currently inside", nargs=0 }
  )

  vapi.nvim_create_user_command(
    "GotoInnerFunctionEnd",
    function() M.GoToFunction({inner=true, goto_end=true}) end,
    { desc="Go to the end of function cursor is currently inside", nargs=0 }
  )
  vapi.nvim_create_user_command(
    "FoldComments",
    function(opts)
      if opts.fargs[1] == "off" then
        vim.o.foldmethod = opts.fargs[2] or "marker"
      end
      vim.o.foldmethod = "expr"
      if opts.fargs[1] == "block" then
        vim.o.foldexpr = "v:lua.require'my_treesitter_module'.fold_comments_block()"
      elseif opts.fargs[1] == "multi" then
        vim.o.foldexpr = "v:lua.require'my_treesitter_module'.fold_comments_multi()"
      elseif not opts.fargs[1] or opts.fargs[1] == "single" then
        vim.o.foldexpr = "v:lua.require'my_treesitter_module'.fold_comments()"
      else
        error("invalid argument")
      end
    end, {
      desc="Fold comments automatically with expr.",
      nargs = '?',
      -- function (ArgLead, CmdLine, CursorPos)
      complete = function(_, cmdline, _)
        local tbl = Split(cmdline, "[ ]+")
        if string.sub(cmdline, -4) == "off" then
          return { "marker", "marker", "manual",  "expr",    "indent",  "syntax",  "diff", }
        else
          return { "single", "block", "multi", "off", }
        end
      end
    }
  )
end

return M

