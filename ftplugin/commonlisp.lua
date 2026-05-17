

vim.g.paredit_help   = "$MY_INFORMATION/lisp/paredit.md"
vim.g.vlime_help     = "$MY_INFORMATION/lisp/vlime.md"
vim.g.slimv_help     = "$MY_INFORMATION/lisp/slimv.md"
vim.bo.commentstring  = ";%s"
vim.bo.tabstop        = 2
vim.bo.shiftwidth     = 2
vim.bo.softtabstop    = 4
vim.bo.expandtab      = true
vim.bo.syntax         = "commonlisp"
vim.bo.filetype       = "lisp" -- ensure for slimv

---Add list of forms to history for repl
---@param forms string[]
function LispAddToHistory(forms)
  if vim.g.slimv_loaded == 1 then
    vim.call("SlimvAddHistory", forms)
  else
    vim.print("Repl not loaded yet...")
  end
end
---evaluates form in lisp repl, defaults to slimv
---@param form string|any[] @string of form or list of values to be computed with vim.fn.printf
---@param options? {
---                  add_to_history: boolean,
---                }
---@return nil|0 @return 0 when vim.fn.SlimvEvalForm is successful
function LispEvalForm(form, options)
  ---@diagnostic disable-next-line: deprecated, param-type-mismatch
  local computed_form = (type(form) == "string" and form) or vim.fn.printf(unpack(form))
  local opts = options or {}
  -- add to history
  if opts.add_to_history then
    LispAddToHistory({computed_form})
  end

  if vim.g.slimv_loaded == 1 then
    return vim.fn.SlimvEvalForm(computed_form)
  else
    vim.print("Repl not loaded yet...")
  end
  return nil
end

function LispEvalFormAddToHistory(form, options)
  local opts = options or {}
  opts.add_to_history = true
  return LispEvalForm(form, opts)
end

---Add directory to asdf:*central-registry*
function LispAddToCentralRegistry(directory)
  if not vim.fn.isdirectory(directory) then
    error(vim.fn.printf("Directory, '%s', doesn't exist.", directory))
  end
  LispEvalForm(vim.fn.printf('(push (truename "%s") asdf:*central-registry*)', directory))
end
function LispAddAllDirectories() ForEach(vim.g.lisp_directories, LispAddToCentralRegistry) end

function LispLoadSystem(system)  LispEvalForm({ '(asdf:load-system :%s)', system } ) end
function LispLoadAllSystems()    ForEach(vim.g.lisp_systems, LispLoadSystem) end

function LispClearSystem(system) LispEvalForm({ '(asdf:clear-system :%s)', system }) end
function LispClearAllSystems()   ForEach(vim.g.lisp_systems, LispClearSystem) end


function LispQuickSetup()
  LispAddAllDirectories()
  LispLoadAllSystems()
end


function LispGetReplBuf()
  if vim.g.slimv_loaded == 1 then
    return GetBufByName(vim.g.slimv_repl_name)
  else
    return nil
  end
end

function LispEvalFromHistory()
  local cmdhistory = vim.g.slimv_cmdhistory
  if cmdhistory then
    vim.call("fzf#run", {
      source = cmdhistory,
      sink   = LispEvalForm,
      options = { '--no-preview' },
    })
  else
    vim.print("No command history found.")
  end
end

-- todo
-- function LispEval(options)
--   local opts           = options or {}
--   local prompt         = opts.prompt or "Expr: "
--   local add_to_history = opts.add_to_history or nil
--   local fn             = opts.fn or LispEvalFormAddToHistory
--   vim.ui.input({prompt=prompt}, fn)
-- end
  

local commonlisp_leader_mappings = {
  n = {
    x   = { desc='execute [sbcl]',          cmd='!sbcl --script "%"' },
    X   = { desc='execute [sbcl] w/ args',  default=':!sbcl --script "%" ' },
    cf  = { desc='format',                  cmd='Autoformat | silent! %s/([ ]\\+/(/g' },
    A   = { group="lisp" },
    Ac  = { desc='complete lisp functions', vim_command='feedkeys(":lua Lisp\\t", "t")' },
    Ae  = { group="lisp eval" },
    Aee = { desc="slimv eval put into 'e",  default='"e\\e' },
    Aeh = { desc='repl eval from history',  default=LispEvalFromHistory },
    Al  = { desc='load system',             vim_command='SlimvEvalForm("(asdf:load-system :" .. g:lisp_session_system .. ")")' },
    Ar  = { desc='reload slimv',            default='\\Q\\c' },
    At  = { desc='test system',             vim_command='SlimvEvalForm("(asdf:test-system :" .. g:lisp_session_system .. ")")' },
    As  = { desc='lisp setup',              lua_call='LispQuickSetup()' },
    Au  = { desc='clear systems',           lua_call='LispClearAllSystems()' },
    Aq  = { group="lisp quicklisp" },
    -- Aqq = { desc='quickload',  function() LispEval({prompt="package", }) end },
-- to-do    -- Aql = { false, 'quickload',       '', lua_call=true },
    Ah  = { group="lisp help" },
    Ahp = { desc='paredit help',            cmd='execute (":vsplit " .. expand(g:paredit_help))' },
    Ahs = { desc='slime help',              cmd='execute (":vsplit " .. expand(g:slime_help))' },
    -- Se  = { false, 'slimv eval at mark e',      '\'e' },
  }

}

--[[
local commonlisp_mappings = {
  i = {
    [ "<C-p>" ] = { false, 'slimv previous command', 'call SlimvPreviousCommand()', cmd=true },
    [ "<C-n>" ] = { false, 'slimv next command', 'call SlimvNextCommand()', cmd=true },
  }
}
KeyMapSetter(commonlisp_mappings, '', true, true)
--]]
KeyMapSetter2(commonlisp_leader_mappings, '<leader>', true, true)
-- "nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:vlime_help))<CR>
-- nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:slimv_help))<CR>
-- nnoremap <buffer> <leader>J :join<CR>

