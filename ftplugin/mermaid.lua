
local MERMAID_KEYMAP_LEADER = {
    ['n'] = {
        ['x'] = { false, "Mermaid Execute (mmdc)", '!mmdc --theme dark --scale 3 --outputFormat png -i %:p', cmd=true },
    }
}
KeyMapSetter(MERMAID_KEYMAP_LEADER, "<leader>", true, true)
