
local tcl_leader_bindings = {
  n = {
    x   = { desc='execute [tcl]',             cmd='!%:p' },
    X   = { desc='execute [tcl] w/ args',     default='!%:p ' },
    A   = { group="tcl"                       },
  }
}

KeyMapSetter2(tcl_leader_bindings, "<leader>", true, true)
