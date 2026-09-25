
---@diagnostic disable: deprecated
-- lua configs for plugins
local config_files   = FN.globpath(vim.g.dir_config .. "/lua/configs/",  "*.lua", false, true)
-- fennel
local compiled_files = FN.globpath(vim.g.dir_config .. "/lua/compiled/", "*.lua", false, true)

vim.opt.rtp:append({
  vim.g.dir_config .. "/lua/configs",
  vim.g.dir_config .. "/lua/compiled",
})
local import_files = {
  { "mappings", "textobjects", "my_treesitter_module" },
  config_files,
  compiled_files,
}
MyImportedModules = {}

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
      else MyImportedModules[f] = response end
    end
  end
end

MyImportedModules["my_treesitter_module"].create_commands()

for v,i in pairs(vim.g.my_toggles) do
  local s, e = pcall(CreateToggle, i)
  if not s then
    PrintPrintf("Error creating toggle: %s\nError: %s\n", v, e)
  end
end
