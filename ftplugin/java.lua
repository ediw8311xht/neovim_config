
require("java").setup({
  spring_boot_tools = {
    enable = false,
    version = '1.55.1',
    path = nil,
    auto_install = false,
  },
})

vim.lsp.enable('jdtls')


local java_leader_mappings = {
   n = {
     Ai  = { desc="java ui",            lua_call="require('java').profile.ui()", },
     Ax  = { desc="run main",           cmd="JavaRunnerRunMain", },
     AX  = { group="run/build", },
     AXx = { desc="[args] run main ",   default=":JavaRunnerRunMain ", },
     AXb = { desc="build workspace",    cmd="JavaBuildBuildWorkspace", },
     AXm = { desc="run current method", cmd="JavaTestRunCurrentMethod", },
   },
 }


KeyMapSetter2(java_leader_mappings, '<leader>', true, true)
