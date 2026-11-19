
require("java").setup({
  spring_boot_tools = {
    enable = true,
    version = '1.55.1',
    path = nil,
    auto_install = true,
  },
})

vim.lsp.enable('jdtls')


local java_leader_mappings = {
   n = {
    A   = { group="[java]" },
    Ai  = { desc="[java] ui",            lua_call="require('java').profile.ui()", },
    Ax  = { desc="run main",           cmd="JavaRunnerRunMain", },

    AX  = { group="run/build", },
    AXx = { desc="[args] run main ",   default=":JavaRunnerRunMain ", },
    AXb = { desc="build workspace",    cmd="JavaBuildBuildWorkspace", },
    AXm = { desc="run current method", cmd="JavaTestRunCurrentMethod", },

    x   = { group="[java] simple", },
    xx  = { desc="[java] exec", default=Bind(ExecuteScript, "basic_java.sh") },
    xX  = { desc="[java] exec args", default=':lua ExecuteScript( "basic_java.sh", ' },
   },
 }





-- KeyMapSetter2(java_leader_mappings, '', true, true) 
KeyMapSetter2(java_leader_mappings, '<leader>', true, true)


--[[

macro for setting getter/setter
"ayeB"byeGkSb get aBvUhxA() {return this.a;}void set abvUhxA(b a) {this.a = a;}

--]]
