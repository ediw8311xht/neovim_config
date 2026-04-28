
--[[ | 
     |-<< top level functions [start] --]]

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
--[[  
    to do
--]]
  local opts = options or {}
  local success, output = pcall(func, opts.args)
  if not success then
    IfCall(vim.notify, vim.fn.printf, {"\nError: \n'%s'\n", success})
    IfCall(opts.on_success ~= nil, opts.on_success, opts.args)
  end
  return {success=success, output=output}
end


-- lua configs for plugins
local config_files   = vim.fn.globpath(vim.g.dir_config .. "/lua/configs/",  "*.lua", 0, 1)
-- fennel
local compiled_files = vim.fn.globpath(vim.g.dir_config .. "/lua/compiled/", "*.lua", 0, 1)

vim.opt.rtp:append({
  vim.g.dir_config .. "/lua/configs",
  vim.g.dir_config .. "/lua/compiled",
})
local import_files = {
  { "helper_functions", "functions", "mappings", "textobjects", "my_treesitter_module" },
  config_files,
  compiled_files,
}
local imported_modules = {}

-- require("nfnl").setup()
for _, i in ipairs(import_files) do
  for _, j in ipairs(i) do
    local f = string.gsub(j, ".*lua/([^.]*).lua$", function(x)
      return x:gsub("/", ".")
    end)
    if not f or f == "" then
      error("Something wrong with requiring file: " .. j)
    else
      local success, response = pcall(require, f)
      if not success then print(response)
      else imported_modules[f] = response end
    end
  end
end

imported_modules["my_treesitter_module"].create_commands()
local fullscreen_window_toggle = {
  command_name = "ToggleFullscreen",
  namespace = "fullscreen",
  scope = "t",
  var = "on",
  on = function()
    vim.t.fullscreen_state = vim.fn.winrestcmd()
    vim.cmd("vertical resize")
    vim.cmd("horizontal resize")
  end,
  off = function()
    vim.cmd("execute t:fullscreen_state")
  end,
}

vim.api.nvim_set_option_value("statusline", vim.g.my_statuslines[1][2], {})
vim.api.nvim_set_option_value("titlestring", vim.g.my_titlestring.default, {})
CreateToggle(fullscreen_window_toggle)

