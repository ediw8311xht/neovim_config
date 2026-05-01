
function IsEmpty(table)
  return next(table) == nil
end

function DeepCopy(value)
  local deep_copy = {}
  if type(value) ~= table then
    return value
  end
  for k,v in table do
    deep_copy[DeepCopy(k)] = DeepCopy(v)
  end
  return deep_copy
end

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

---@param table table
---@param func function<any, any> @func(value, key)
function ForEach(table, func)
  for k,v in pairs(table) do
    func(v, k)
  end
end

---@param table table
---@param func fun(value, key): new_value: any, new_key: any
function Map(table, func)
  local new_table = {}
  for k,v in pairs(table) do
    local nv, nk = func(v, k)
    new_table[nk] = nv
  end
  return new_table
end

---@param table table
---@param func fun(accum, value, key): any
---@return any @accumulation
function Reduce(table, func, initial)
  local accum = initial
  for k,v in pairs(table) do
    accum = func(accum, v, k)
  end
  return accum
end

function TableSetDefault(tbl, default)
  return setmetatable(tbl, { __index = function() return default end })
end

