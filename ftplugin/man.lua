MAN_MAPPINGS = {
  n = {
    q = { desc="quit", default="ZQ", nowait=true },
    o = { desc="next section", vim_call='search("^\\\\S.*$", "W")' },
    O = { desc="previous section", vim_call='search("^\\\\S.*$", "Wb")' },
    [ '<leader>As' ] = { desc="search for keyword", default='/\\v\\n([ ]*)\\zs' },
  },
}

KeyMapSetter2(MAN_MAPPINGS, "", true, true)
