MAN_MAPPINGS = {
  n = {
    q = { desc="quit", default="ZQ" },
    o = { desc="next section", default='/\\v\\n([ ]*)\\zs[^ ]\\ze.*\\n\\1[ ]+<CR>' },
    O = { desc="previous section", default='?\\v\\n([ ]*)\\zs[^ ]\\ze.*\\n\\1[ ]+<CR>' },
    [ '<leader>As' ] = { desc="search for keyword", default='/\\v\\n([ ]*)\\zs' },
  },
}

KeyMapSetter2(MAN_MAPPINGS, "", false, true)
