
lua <<EOF
    page_keymap_leader = {
        ['n'] = {
            ['Sx'] = { false, "update gitit", ':!$MY_WIKI/commit_push.sh --quick<CR>' },
        }
    }
    KeyMapSetter(page_keymap_leader, "<leader>", true, true)
EOF
