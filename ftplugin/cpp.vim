
"function CPPComments()
"    set
"endfu
"
"function ToggleCPPComments()
"    " Prevents error when `b:cpp_commented_out` hasn't been set.
"    let l:val=get(b:, "cpp_commented_out")
"    if l:val
"        setlocal
"        let b:fold
"    else
"    endif
"    let b:cpp_commented_out=!l:val
"endfu

"let b:cpp_commented_out=0
lua <<EOF
vim.b.cpp_keymap_leader = {
    ["n"] =  {
        ["x"]   =  { false, 'make run', ':!"$HOME/bin/make_run_cpp.sh" %<esc>',         },
        ["X"]   =  { false, 'make run (args)', ':!"$HOME/bin/make_run_cpp.sh" %',       },
        ["xv"]  =  { false, 'make run (auto)', ':!"$HOME/bin/make_run_cpp.sh" <esc>',   },
        ["cF"]  =  { false, 'clang format', ':%!clang-format <esc>',                    },
        -- ["cT"]  =  { false, 'ToggleComments', ':call ToggleCPPComments()<CR>',        },
    },
    ["v"] = {
        ["cF"]  =  { false, 'clang format', ':%!clang-format <esc>',                },
    },
}

KeyMapSetter(vim.b.cpp_keymap_leader, "<leader>", true, true)
EOF

setlocal tabstop=2 shiftwidth=2 softtabstop=4 expandtab
set keywordprg=cppman


