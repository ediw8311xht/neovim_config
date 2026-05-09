

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

-- ---Add directories defined in vim.g.lisp_directories to asdf:*central-registry* {{{
-- ---@param verbose? boolean @print directories that are added to central registry
-- function LispAddToCentralRegistry(verbose)
--   if type(vim.g.lisp_directories) ~= "table" then
--     -- error("vim.g.lisp_directories must be set to a list of directories")
--     return
--   end
--   for _,i in ipairs(vim.g.lisp_directories) do
--   end
-- end }}}

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
    })
  else
    vim.print("No command history found.")
  end
end

local commonlisp_leader_mappings = {
  n = {
    x   = { false, 'execute [sbcl]',         '!sbcl --script "%"', cmd=true },
    X   = { false, 'execute [sbcl] w/ args', ':!sbcl --script "%" ' },
    cf  = { false, 'format',          'Autoformat | silent! %s/([ ]\\+/(/g', cmd=true },
    A   = { group="lisp" },
    Ac  = { false, 'complete lisp functions', 'feedkeys(":lua Lisp\\t", "t")', vim_command=true },
    Ae  = { group="lisp eval" },
    Aee = { false, "slimv eval put into 'e" ,   '"e\\e' },
    Aeh = { false, 'repl eval from history', LispEvalFromHistory },
    Af  = { false, 'reload slimv',    '\\Q\\c' },
    Al  = { false, 'load system',     'SlimvEvalForm("(asdf:load-system :" .. g:Session_system .. ")")', vim_command=true },
    Ar  = { false, 'reload slimv',    '\\Q\\c' },
    At  = { false, 'test system',     'SlimvEvalForm("(asdf:test-system :" .. g:Session_system .. ")")', vim_command=true },
    As  = { false, 'lisp setup',      'LispQuickSetup()', lua_call=true },
    Au  = { false, 'clear systems',   'LispClearAllSystems()', lua_call=true },
    Ah  = { group="lisp help" },
    Ahp = { false, 'paredit help',    'execute (":vsplit " .. expand(g:paredit_help))', cmd=true },
    Ahs = { false, 'slime help',      'execute (":vsplit " .. expand(g:slime_help))', cmd=true },
    -- Se  = { false, 'slimv eval at mark e',      '\'e' },
  }

}

local commonlisp_mappings = {
  i = {
    [ "<C-p>" ] = { false, 'slimv previous command', 'call SlimvPreviousCommand()', cmd=true },
    [ "<C-n>" ] = { false, 'slimv next command', 'call SlimvNextCommand()', cmd=true },
  }
}
KeyMapSetter(commonlisp_mappings, '', true, true)
KeyMapSetter(commonlisp_leader_mappings, '<leader>', true, true)
-- "nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:vlime_help))<CR>
-- nnoremap <buffer> <leader>hh :execute (':vsplit ' . expand(g:slimv_help))<CR>
-- nnoremap <buffer> <leader>J :join<CR>

