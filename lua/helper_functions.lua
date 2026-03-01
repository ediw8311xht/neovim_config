
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
  if callback == nil then callback = (function(a,b) return a == b end) end
  for _,v in ipairs(t) do
    if callback(v, check_value) then
      return true
    end
  end
  return false
end

function Split(str, v, options)
  local l = {}
  local default_opts = {
    callback   = function(c, t) table.insert(t, c) end,
    str_append = v,
  }
  options = TableDifference(default_opts, options or {}, false)
  for catch in string.gmatch(str .. options.str_append, '(.-)('.. v .. ')') do
    print(catch)
    options.callback(catch, l)
  end
  return l
end

