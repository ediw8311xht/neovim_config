
---@alias EvalOptions { add_to_history: boolean }

vim.g.paredit_help   = "$MY_INFORMATION/lisp/paredit.md"
vim.g.vlime_help     = "$MY_INFORMATION/lisp/vlime.md"
vim.g.slimv_help     = "$MY_INFORMATION/lisp/slimv.md"
vim.bo.commentstring  = ";%s"
vim.bo.tabstop        = 2
vim.bo.shiftwidth     = 2
vim.bo.softtabstop    = 4
vim.bo.expandtab      = true
vim.bo.syntax         = "lisp"
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
---@param options? EvalOptions
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

function LispEvalForms(forms, options)
  for _,f in ipairs(forms) do
    local form, lopts = nil, options
    if type(f) == table then
      form = f[1]
      lopts = f[2]
    else
      form = f
    end
    LispEvalForm(form, lopts)
  end
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
  return (vim.g.slimv_loaded == 1 and GetBufByName(vim.g.slimv_repl_name)) or nil
end

function LispEvalFZF(coms, options, ...)
  local opts = options or {}
  if type(coms) == "table" and coms[1] then
    vim.call("fzf#run", {
      source = coms,
      sink = function(x) LispEvalForm(x, opts) end,
      options = { '--no-preview', ... }
    })
  else
    vim.print(opts.error or "No commands found in passed datastructure")
  end
end

---@param options EvalOptions|table
function LispEvalInput(options)
  local opts           = options or {}
  local prompt         = opts.prompt or "expr: "
  local printf         = opts.printf
  local fn
  if printf then
    fn = function(x) LispEvalForm(Printf(printf, x), opts) end
  else
    fn = opts.fn or function(x) LispEvalForm(x, opts) end
  end
  vim.ui.input({prompt=prompt}, fn)
end

function LispEvalFromHistory()  LispEvalFZF(vim.fn.reverse(vim.g.slimv_cmdhistory), {error="No command history found."}) end
function LispEvalSavedForms()   LispEvalFZF(vim.g.lisp_saved_forms, {error="No command history found."}) end
function LispEvalStartupForms() LispEvalForms(vim.g.lisp_startup_forms) end
function LispQlQuickload()      LispEvalInput({prompt="quickload package: ", printf='(ql:quickload "%s")', add_to_history=false }) end


-- function CreateToggle(options: { namespace: string, scope: string, description: string, command_name: string, var: string, on: function, off: function })

local commonlisp_mappings = {
  [ {"n", "i", "v"} ] = {
    ["<C-S-i>"] = { desc="toggle floating repl", cmd='keepalt lua FloatingWindowToggle("cl-repl", false, {height=80})' },
    ["<C-j>"]   = { desc="[repl] next history", cmd="call SlimvHandleDown()", },
    ["<C-k>"]   = { desc="[repl] prev history", cmd="call SlimvHandleUp()", },
  },
}
local commonlisp_leader_mappings = {
  n = {
    cf  = { desc='format',                     cmd='Autoformat | silent! %s/([ ]\\+/(/g' },

    A   = { group="lisp" },

    ASc = { desc="set clesh shebang",          lua_call='vim.api.nvim_buf_set_lines(0, 0, 0, false, {"#!/usr/bin/env clesh_script.sh"})' },
    AX  = { desc='execute [sbcl] w/ args',     default=':!sbcl --script "%" ' },
    Ac  = { desc='complete lisp functions',    vim_call='feedkeys(":lua Lisp\\t", "t")' },

    Ae  = { group="lisp eval" },
    AeS = { desc="eval startup forms",         default=LispEvalStartupForms },
    Aee = { desc="slimv eval put into 'e",     default='"e\\e', remap=true },
    Aef = { desc="eval input",                 default=Bind(LispEvalInput, {add_to_history=true} ) },
    Aeh = { desc='repl eval from history',     default=LispEvalFromHistory },
    Aer = { desc="slimv eval 'e",              default='"e\\r', remap=true },
    Aes = { desc='repl eval from saved forms', default=LispEvalSavedForms },

    Ah  = { group="lisp help"                  },
    Ahp = { desc='paredit help',               cmd='execute (":vsplit " .. expand(g:paredit_help))' },
    Ahs = { desc='slime help',                 cmd='execute (":vsplit " .. expand(g:slime_help))' },
    Al  = { desc='load system',                default=function() LispLoadSystem(vim.g.lisp_session_system) end },
    Aq  = { group="lisp quicklisp"             },

    Aqq = { desc='[ql] quickload',             default=LispQlQuickload },
    Ar  = { desc='reload slimv',               default='\\Q\\c' },
    As  = { desc='lisp setup',                 default=LispQuickSetup },
    At  = { desc='test system',                vim_call='SlimvEvalForm("(asdf:test-system :" .. g:lisp_session_system .. ")")' },
    Au  = { desc='clear systems',              default=LispClearAllSystems },
    Ax  = { desc='execute [sbcl]',             cmd='!sbcl --script "%"' },
    -- Se  = { false, 'slimv eval at mark e',      '\'e' },
  }
}


KeyMapSetter2(commonlisp_mappings,        '', true, true)
KeyMapSetter2(commonlisp_leader_mappings, '<leader>', true, true)

-- vim.cmd([[
--     augroup SlimvReplAutoCmd
--         au!
--     augroup END
--     ]])
