
---@diagnostic disable: deprecated
function IsEmpty(tbl)
  return next(tbl) == nil
end

---Deep copy
---@generic T : any
---@param var T
---@return T
function DeepCopy(var)
  if type(var) ~= "table" then
    return var
  else
    local deep_copy = {}
    for k,v in pairs(var) do
      deep_copy[DeepCopy(k)] = DeepCopy(v)
    end
    return deep_copy
  end
end

---Difference between two tables with table_b taking priority over table_a
---@param table_a table
---@param table_b table
---@param in_place? boolean
---@return table
function TableDifference(table_a, table_b, in_place)
  -- allow editing in place or passing new table
  local output = (in_place ~= nil) and table_a or DeepCopy(table_a)
  for i,j in pairs(table_b) do
    output[i] = j
  end
  return output
end

function EnvVarCheck(var)
  local e = os.getenv(var)
  if e == nil or e == '' then
    return false
  else
    return e
  end
end

function Contains(t, check_value, callback)
  callback = callback or (function(a,b) return a == b end)
  for _,v in ipairs(t) do
    if callback(v, check_value) then
      return true
    end
  end
  return false
end

---Iterate over string on split of string/regex
---@param s     string The string to split
---@param f     string The string/regex to split on
---@param opts? {callback : function, output_data : table, remove_empty : boolean} Options
---   `callback (match, output_data)` - Function called on matches
---       default: `function(c, t) table.insert(t, c) end`
---   `output_data` - Data returned
---       default: `{}`
---   `remove_empty` - Don't process empty matches
---       default: `false`
function MapSplit(s, f, opts)
  opts = opts or {}
  if     s == nil then return {}
  elseif s == ""  then return opts.remove_empty and {} or { "" } end
  local output_data  = opts.output_data   or {}
  local callback     = opts.callback      or function(m, t) table.insert(t, m) end
  local remove_empty = opts.remove_empty  or false

  repeat
    local match, _, rest = string.match(s, '^(.-)(' .. f .. ')(.*)$')
    if not remove_empty or match ~= "" then
      callback(match or s, output_data)
    end
    s = rest
  until (not s or s == "")
  return output_data
end

--- Split string into list based on string/regex
---@param s string  The string to split
---@param f string  The string/regex to split on
function Split(s, f)
  return MapSplit(s, f)
end

---@param tbl table
---@param func function<any, any> @func(value, key)
function ForEach(tbl, func)
  for k,v in pairs(tbl) do
    func(v, k)
  end
end

---@param tbl table
---@param func fun(value, key): new_value: any, new_key: any
function Map(tbl, func)
  local new_tbl = {}
  for k,v in pairs(tbl) do
    local nv, nk = func(v, k)
    if nk == nil then
      table.insert(new_tbl, nv)
    else
      new_tbl[nk] = nv
    end
  end
  return new_tbl
end

---@param tbl table
---@param func fun(accum, value, key): any
---@param initial? any
---@return any @accumulation
function Reduce(tbl, func, initial)
  local accum = initial
  for k,v in pairs(tbl) do
    accum = func(accum, v, k)
  end
  return accum
end

function TableSetDefault(tbl, default)
  return setmetatable(tbl, { __index = function() return default end })
end

function Printf(s, ...)
  vim.print(vim.fn.printf(s, ...))
end

function SourceIf(file)
  local expand_file = vim.fn.expand(file)
  if vim.fn.filereadable(expand_file) then
    vim.cmd.source(expand_file)
    return true
  else
    Printf("File: '%s' not found", expand_file)
  end
end

---if test then call func(args) end
---@param test     function|any @func or variable to test to
---@param if_func  function     @func to call if test()/test
---@param options? {
---                   args:      table,    @args to pass to test
---                   else_func: function, @func to call if not test()/test
---                   test_args: table,    @args to pass to test
---                   if_args:   table,    @args to pass to if_func
---                   else_args: table,    @args to pass to if_func
---                 }
function IfCall(test, if_func, options)
  local opts = options or {}
  if type(test) == "function" then
    return    test(unpack(opts.test_args))
       and if_func(unpack(opts.if_args or {}))
  else
    if test then
      if_func(unpack(opts.if_args or {}))
    else
      opts.else_func(opts.else_args or {})
    end
  end
end
---Catches error and runs option callback on success/error
---f
---@param func function
---@param options? {
---                   args: table,
---                   notify: boolean,
---                   on_success: function,
---                   on_error:  function,
---                }
---@return { success: boolean, output: any }
function CatchError(func, options)
  local opts = options or {}
  local success, output = pcall(func, opts.args)
  if not success then
    IfCall(vim.notify, vim.fn.printf, {"\nError: \n'%s'\n", success})
    IfCall(opts.on_success ~= nil, opts.on_success, opts.args)
  end
  return {success=success, output=output}
end

