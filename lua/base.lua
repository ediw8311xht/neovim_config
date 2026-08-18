
---@diagnostic disable: deprecated
-- lua configs for plugins
local config_files   = vim.fn.globpath(vim.g.dir_config .. "/lua/configs/",  "*.lua", 0, 1)
-- fennel
local compiled_files = vim.fn.globpath(vim.g.dir_config .. "/lua/compiled/", "*.lua", 0, 1)

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

-- vim.api.nvim_set_option_value("statusline", vim.g.my_statuslines[1][2], {})
-- vim.api.nvim_set_option_value("titlestring", vim.g.my_titlestring.default, {})
CreateToggle(vim.g.fullscreen_window_toggle)

