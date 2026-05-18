

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

function LispEvalFZF(coms, options)
  if type(coms) == "table" and coms[1] then
    vim.call("fzf#run", {
      source = coms,
      sink = function(x) LispEvalForm(x, options) end,
      options = { '--no-preview' }
    })
  else
    vim.print(options.error or "No commands found in passed datastructure")
  end
end

function LispEval(options)
  local opts           = options or {}
  local prompt         = opts.prompt or "Expr: "
  local printf         = opts.printf
  local fn
  -- local add_to_history = opts.add_to_history or nil
  if printf then
    fn = function(x) LispEvalForm(vim.fn.printf(printf, x), opts) end
  else
    fn = opts.fn or function(x) LispEvalForm(x, opts) end
  end

  vim.ui.input({prompt=prompt}, fn)
end

function LispEvalFromHistory()
  LispEvalFZF(vim.g.slimv_cmdhistory, {error="No command history found."})
end

function LispEvalSavedForms()
  LispEvalFZF(vim.g.lisp_saved_forms, {error="No command history found."})
end

function LispQlQuickload()
  LispEval({prompt="quickload package: ", printf='(ql:quickload "%s")', add_to_history=nil })
end

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
    Aes = { desc='repl eval from saved forms',  default=LispEvalSavedForms },
    Al  = { desc='load system',             vim_command='SlimvEvalForm("(asdf:load-system :" .. g:lisp_session_system .. ")")' },
    Ar  = { desc='reload slimv',            default='\\Q\\c' },
    At  = { desc='test system',             vim_command='SlimvEvalForm("(asdf:test-system :" .. g:lisp_session_system .. ")")' },
    As  = { desc='lisp setup',              default=LispQuickSetup },
    Au  = { desc='clear systems',           default=LispClearAllSystems },
    Aq  = { group="lisp quicklisp" },
    Aqq = { desc='[ql] quickload',          default=LispQlQuickload },
    Ah  = { group="lisp help" },
    Ahp = { desc='paredit help',            cmd='execute (":vsplit " .. expand(g:paredit_help))' },
    Ahs = { desc='slime help',              cmd='execute (":vsplit " .. expand(g:slime_help))' },
    -- Se  = { false, 'slimv eval at mark e',      '\'e' },
  }

}

KeyMapSetter2(commonlisp_leader_mappings, '<leader>', true, true)
--[[
local commonlisp_mappings = {
  i = {
    [ "<C-p>" ] = { false, 'slimv previous command', 'call SlimvPreviousCommand()', cmd=true },
    [ "<C-n>" ] = { false, 'slimv next command', 'call SlimvNextCommand()', cmd=true },
  }
}
KeyMapSetter(commonlisp_mappings, '', true, true)
--]]
-- "nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:vlime_help))<CR>
-- nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:slimv_help))<CR>
-- nnoremap <buffer> <leader>J :join<CR>

