#!/usr/bin/lua

local F = false
-- local T = true
vim.g.mapping_file = vim.fn.expand('%:p')

-- Leader Mappings {{{
---------- Remember -----------
-- innoremap <expr> key command
-------------------------------
LEADER_MAPPINGS = {
  n = {
    B     = { group="buffer"},
    Bc    = { F, 'copy buffer to clip',     'gg"+yG<c-o>'},
    Bd    = { F, 'delete buffer',           'bd',cmd=true},
    Bn    = { F, 'new buffer',              'enew',cmd=true},
    E     = { F, 'cwd edit',                'vim.fn.feedkeys(":e " .. GetFile({tilde_home=true, expand="%:p:h"}) .. "/")',lua_call=true},
    F     = { group="AutoSession"},
    Fa    = { F, '[!]session auto save',    'AutoSession toggle',cmd=true},
    Fc    = { F, 'session search',          'AutoSession search',cmd=true},
    Fsa   = { F, '[args] session save',     ':AutoSession save '},
    Fss   = { F, 'session save',            'AutoSession save',cmd=true},
    G     = { group="messages"},
    Gc    = { F, 'clear notifications',     'require("notify").dismiss({silent = true})', lua_call=true },
    Gh    = { F, 'checkhealth',             'checkhealth',cmd=true},
    Gm    = { F, 'messages',                'messages',cmd=true},
    Gn    = { F, 'notifications',           'Notifications',cmd=true},
    Gu    = { F, 'get undo list',           'undolist',cmd=true},
    H     = { group="help"},
    HM    = { F, 'print all mappings',      'GetMappings()',lua_call=true},
    Hg    = { F, 'helpgrep',                ':vert helpgrep '},
    Hh    = { F, 'get highlight',           'GetHL()',lua_call=true},
    Hk    = { F, 'vim help tags',           'Telescope help_tags',cmd=true},
    Hm    = { F, 'open mappings file',      'edit ' .. vim.g.mapping_file,cmd=true},
    Ho    = { F, 'vim options',             'Telescope vim_options',cmd=true},
    Ht    = { F, 'telescope commands',      'Telescope commands',cmd=true},
    I     = { group="lsp"},
    IA    = { F, 'stop lsp',                'lsp stop',cmd=true},
    Ia    = { F, 'start lsp',               'lsp enable',cmd=true}, -- this sucks need to find way to start only those defined by nvim lsp config
    Ir    = { F, 'restart lsp',             'lsp restart',cmd=true},
    Ic    = { F, 'show code-action',        'require("actions-preview").code_actions()',lua_call=true},
    Id    = { F, 'go to definition',        'vim.lsp.buf.definition()',lua_call=true},
    Ihc   = { F, 'clear highlight symbol',  'vim.lsp.buf.clear_references()',lua_call=true},
    Ihs   = { F, 'highlight symbol',        'LspDocumentHighlight()',lua_call=true},
    Ii    = { F, 'show diagnostics',        'vim.diagnostic.open_float(nil, {focus=T, scope="cursor"})',lua_call=true},
    Il    = { F, 'hover lsp info',          'vim.lsp.buf.hover({max_height=30, max_width=30})',lua_call=true},
    In    = { F, 'goto next error',         'vim.diagnostic.goto_next()',lua_call=true},
    Ip    = { F, 'goto prev error',         'vim.diagnostic.goto_prev()',lua_call=true},
    Iy    = { F, '[!]lsp_lines',            'require("lsp_lines").toggle()',lua_call=true},
    M     = { group="misc"},
    MT    = { F, 'new terminal',            'term',cmd=true},
    Mc    = { F, 'set pwd to currfile',     'cd %:p:h',cmd=true},
    Me    = { F, 'telescope',               'Telescope',cmd=true},
    Mn    = { F, 'new file',                'enew',cmd=true},
    Mt    = { F, 'new tab',                 'tabnew',cmd=true},
    O     = { group="open"},
    Ob    = { F, 'open in browser',         'silent !"${BROWSER:-"brave"}"  %',cmd=true},
    Oq    = { F, 'open in qutebrowser',     'silent !"qutebrowser" %',cmd=true},
    Or    = { F, 'recent files',            'Telescope oldfiles',cmd=true},
    S     = { group="execution"},
    SX    = { F, 'execute with args',      ':!%'},
    Sl    = { F, 'luafile',                'luafile %',cmd=true},
    Ss    = { F, 'source file',            '%so',cmd=true},
    Sx    = { F, 'execute',                '!%',cmd=true},
    T     = { group="treesitter"},
    Tl    = { F, 'get treesitter parser',   'lua= vim.treesitter.get_parser(0):lang()',cmd=true},
    Ts    = { F, 'treesitter status',       'lua= MyTreesitterStatus()',cmd=true},
    Tt    = { F, 'open treesitter tree',    'lua vim.treesitter.inspect_tree()',cmd=true},
    U     = { F, 'lf cd',                   'Lfcd',cmd=true},
    W     = { F, 'write',                   ':w<ESC>'},
    b     = { F, 'open buffer',             function() require("telescope.builtin").buffers({ignore_current_buffer=true, disable_coordinates = true}) end },
    c     = { group="editor setting"},
    cA    = { F, 'fold comments',           'AutoFoldComments multi',cmd=true},
    cB    = { F, 'prev background',         'CyBack(-1)',vim_command=true},
    cC    = { F, '[!]folds in gutter',      'TogFoldColumn()',vim_command=true},
    cJ    = { F, 'prev scheme',             'SetColScheme(-1)',vim_command=true},
    cL    = { F, 'cycle statusline',        'lua= Cycle("statusline", vim.g.my_statuslines)',cmd=true},
    cS    = { F, '[!]spell',                'set spell!',cmd=true},
    ca    = { F, 'fold comments',           'AutoFoldComments off',cmd=true},
    cb    = { F, 'next background',         'CyBack(+1)',vim_command=true},
    cc    = { F, '[!]line length indicator','TogColorColumn()',vim_command=true},
    ce    = { F, '[!]cursorcolumn',         'set cuc!',cmd=true},
    cf    = { F, 'format',                  'lua RunKeepCursorPosition(function() vim.cmd(":Autoformat") end)',cmd=true},
    cg    = { F, '[!]git signs',            'Gitsigns toggle_linehl',cmd=true},
    ch    = { F, 'format2',                 'vim.lsp.buf.format()', lua_call=true },
    cj    = { F, 'next scheme',             'SetColScheme(+1)',vim_command=true},
    ck    = { F, 'correctcolors()',         'lua CorrectColors()',cmd=true},
    cl    = { F, '[!]cursorline',           'lua ToggleHighlight({"CursorLine"})',cmd=true},
    cr    = { F, '[!]rainbow',              'rainbow_delimiters#toggle(0)',vim_command=true},
    cs    = { F, '[!]statusline',           'TogLastStatus()',vim_command=true},
    cv    = { F, '[!]virtualedit',          'TogVirtualEdit()',vim_command=true},
    cw    = { F, '[!]wrap',                 'set wrap!',cmd=true},
    df    = { F, 'find space eol',          '%s/\\s\\+\\ze$//gc',cmd=true},
    grg   = { F, 'search in all buffers',   function() require("telescope.builtin").live_grep({grep_open_files = true, disable_coordinates = true}) end },
    i     = { F, 'show diagnostics',        'vim.diagnostic.open_float(nil, {focus=T, scope="cursor"})',lua_call=true},
    s     = { F, 'switch pane',             '<C-w><C-p>'},
    u     = { F, 'lf file manager',         'Lf',cmd=true},
    vt    = { F, 'title case',              's/\\v\\c\\w(\\a*(\'\\a{0,1})?\\w)?/\\u\\0/g | nohl', cmd=true},
    wj    = { F, 'decrease size split',     '40<c-w><'},
    wk    = { F, 'increase size split',     '40<c-w>>'},
    wo    = { F, 'toggle fullscreen',       'ToggleFullscreen',cmd=true},
    x     = { F, 'execute',                 '!%:p',cmd=true},
    y     = { F, 'bg transparent',          'hi Normal guibg=Transparent',cmd=true},
    z     = { F, '',                        'z'},
    [ ','       ] = { F, 'alternate file',         '<C-^>'},
    [ '-'       ] = { F, 'resize split -20',       '20<c-w><'},
    [ '<C-S-x>' ] = { F, 'execute with args',      ':!%:p '},
    [ '<C-s>'   ] = { F, 'sub in all buffs',       ':budfo %s/\\v\\c'},
    [ '<C-x>'   ] = { F, 'execute',                ':!%:p<ESC>'},
    [ '<S-Tab>' ] = { F, 'later',                  'later',cmd=true},
    [ '<Tab>'   ] = { F, 'earlier',                'earlier',cmd=true},
    [ '='       ] = { F, 'resize split +20',       '20<c-w>>'},
    [ '['       ] = { F, 'prev buffer',            'bprevious',cmd=true},
    [ ']'       ] = { F, 'next buffer',            'bnext',cmd=true},
  },
  v = {
    vc     = { F, 'column',                 ':%!column -o " " -t<ESC>'},
    vmf    = { F, 'bc [math] float',        ':!bc -l<ESC>'},
    vmi    = { F, 'bc [math] int',          ':!bc -l<ESC>'},
    vmq    = { F, 'qalc [math]',            ':!xargs qalc --color=never --terse<ESC>'},
    vs     = { F, 'sort',                   ':sort<ESC>',},
    vt     = { F, 'title case',             ':s/\\%V\\v\\c\\w(\\a*(\'\\a{0,1})?\\w)?/\\u\\0/g<CR>'},
    -- vx     = { F, 'execute selection',      'lua 
  },
  [ { "v", "n" } ] = {
  }
} --}}}
KeyMapSetter(LEADER_MAPPINGS, "<leader>", false,true)

-- get region 			      
-- PERSONAL_MAPPINGS = { ["regular"] = REGULAR_MAPPINGS, ["leader"] = LEADER_MAPPINGS }
-- KeyMapSetter(REGULAR_MAPPINGS, "", false,true)

--[[ info {{{
 _____________________________________________________________________________
 ||                                                                         ||
 ||                                                         [*map-table*]   ||
 ||            Mode  | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang |   ||
 ||   Command        +------+-----+-----+-----+-----+-----+------+------+   ||
 ||   [nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |   ||
 ||   n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |   ||
 ||   [nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |   ||
 ||   i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |   ||
 ||   c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |   ||
 ||   v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |   ||
 ||   x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |   ||
 ||   s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |   ||
 ||   o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |   ||
 ||   t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |   ||
 ||   l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |   ||
 ||_________________________________________________________________________||
 ||                                                                         ||
 ||   1.4 LISTING MAPPINGS                                [*map-listing*]   ||
 ||                                                                         ||
 ||   When listing mappings the characters in the first two columns are:    ||
 ||                                                                         ||
 ||    CHAR     MODE                                                        ||
 ||   <Space>   Normal, Visual, Select and Operator-pending                 ||
 ||      n      Normal                                                      ||
 ||      v      Visual and Select                                           ||
 ||      s      Select                                                      ||
 ||      x      Visual                                                      ||
 ||      o      Operator-pending                                            ||
 ||      !      Insert and Command-line                                     ||
 ||      i      Insert                                                      ||
 ||      l      ":lmap" mappings for Insert, Command-line and Lang-Arg      ||
 ||      c      Command-line                                                ||
 ||      t      Terminal-Job                                                ||
 ||-------------------------------------------------------------------------||
 || mode([{expr}])                                             [*mode()*]   ||
 ||_________________________________________________________________________||________
 ||    n         | Normal                                                           ||
 ||    no        | Op-pending                                                       ||
 ||    nov       | Op-pending (forced charwise |o_v|)                               ||
 ||    noV       | Op-pending (forced linewise |o_V|)                               ||
 ||    noCTRL-V  | Op-pending (forced blockwise |o_CTRL-V|) CTRL-V is one character ||
 ||    niI       | Normal using |i_CTRL-O| in |Insert-mode|                         ||
 ||    niR       | Normal using |i_CTRL-O| in |Replace-mode|                        ||
 ||    niV       | Normal using |i_CTRL-O| in |Virtual-Replace-mode|                ||
 ||    nt        | Normal in |terminal-emulator| (insert goes to Terminal mode)     ||
 ||    ntT       | Normal using |t_CTRL-\_CTRL-O| in |Terminal-mode|                ||
 ||    v         | Visual by character                                              ||
 ||    vs        | Visual by character using |v_CTRL-O| in Select mode              ||
 ||    V         | Visual by line                                                   ||
 ||    Vs        | Visual by line using |v_CTRL-O| in Select mode                   ||
 ||    CTRL-V    | Visual blockwise                                                 ||
 ||    CTRL-Vs   | Visual blockwise using |v_CTRL-O| in Select mode                 ||
 ||    s         | Select by character                                              ||
 ||    S         | Select by line                                                   ||
 ||    CTRL-S    | Select blockwise                                                 ||
 ||    i         | Insert                                                           ||
 ||    ic        | Insert mode completion |compl-generic|                           ||
 ||    ix        | Insert mode |i_CTRL-X| completion                                ||
 ||    R         | Replace |R|                                                      ||
 ||    Rc        | Replace mode completion |compl-generic|                          ||
 ||    Rx        | Replace mode |i_CTRL-X| completion                               ||
 ||    Rv        | Virtual Replace |gR|                                             ||
 ||    Rvc       | Virtual Replace mode completion |compl-generic|                  ||
 ||    Rvx       | Virtual Replace mode |i_CTRL-X| completion                       ||
 ||    c         | Command-line editing                                             ||
 ||    cr        | Command-line editing overstrike mode |c_<Insert>|                ||
 ||    cv        | Vim Ex mode |gQ|                                                 ||
 ||    cvr       | Vim Ex mode while in overstrike mode |c_<Insert>|                ||
 ||    r         | Hit-enter prompt                                                 ||
 ||    rm        | The -- more -- prompt                                            ||
 ||    r?        | A |:confirm| query of some sort                                  ||
 ||    !         | Shell or external command is executing                           ||
 ||    t         | Terminal mode: keys go to the job                                ||
 ||_________________________________________________________________________________||


|-----------------------------------------------------------------------------------------------|
| 2. Special special keys | :help ins-special-special                                           |
|-----------------------------------------------------------------------------------------------|
| The following keys are special.  They stop the current insert, do something,|
| and then restart insertion.  This means you can do something without getting                  |
| out of Insert mode.  This is very handy if you prefer to use the Insert mode                  |
| all the time, just like editors that don't have a separate Normal mode. You                   |
| can use CTRL-O if you want to map a function key to a command.                                |
|                                                                                               |
| The changes (inserted or deleted characters) before and after these keys can                  |
| be undone separately.  Only the last change can be redone and always behaves                  |
| like an "i" command.                                                                          |
|-----------------------------------------------------------------------------------------------|

| char                 | action                                       | help page               |
| -------------------- | -------------------------------------------- | ----------------------- |
| <Up>                 |  cursor one line up                          | i_<Up>                  |
| <Down>               |  cursor one line down                        | i_<Down>                |
| CTRL-G <Up>          |  cursor one line up, insert start column     | i_CTRL-G_<Up>           |
| CTRL-G k             |  cursor one line up, insert start column     | i_CTRL-G_k              |
| CTRL-G CTRL-K        |  cursor one line up, insert start column     | i_CTRL-G_CTRL-K         |
| CTRL-G <Down>        |  cursor one line down, insert start column   | i_CTRL-G_<Down>         |
| CTRL-G j             |  cursor one line down, insert start column   | i_CTRL-G_j              |
| CTRL-G CTRL-J        |  cursor one line down, insert start column   | i_CTRL-G_CTRL-J         |
| <Left>               |  cursor one character left                   | i_<Left>                |
| <Right>              |  cursor one character right                  | i_<Right>               |
| <S-Left>             |  cursor one word back (like "b" command)     | i_<S-Left>              |
| <C-Left>             |  cursor one word back (like "b" command)     | i_<C-Left>              |
| <S-Right>            |  cursor one word forward (like "w" command)  | i_<S-Right>             |
| <C-Right>            |  cursor one word forward (like "w" command)  | i_<C-Right>             |
| <Home>               |  cursor to first char in the line            | i_<Home>                |
| <End>                |  cursor to after last char in the line       | i_<End>                 |
| <C-Home>             |  cursor to first char in the file            | i_<C-Home>              |
| <C-End>              |  cursor to after last char in the file       | i_<C-End>               |
| <LeftMouse>          |  cursor to position of mouse click           | i_<LeftMouse>           |
| <S-Up>               |  move window one page up                     | i_<S-Up>                |
| <PageUp>             |  move window one page up                     | i_<PageUp>              |
| <S-Down>             |  move window one page down                   | i_<S-Down>              |
| <PageDown>           |  move window one page down                   | i_<PageDown>            |
| <ScrollWheelDown>    |  move window three lines down                | i_<ScrollWheelDown>     |
| <S-ScrollWheelDown>  |  move window one page down                   | i_<S-ScrollWheelDown>   |
| <ScrollWheelUp>      |  move window three lines up                  | i_<ScrollWheelUp>       |
| <S-ScrollWheelUp>    |  move window one page up                     | i_<S-ScrollWheelUp>     |
| <ScrollWheelLeft>    |  move window six columns left                | i_<ScrollWheelLeft>     |
| <S-ScrollWheelLeft>  |  move window one page left                   | i_<S-ScrollWheelLeft>   |
| <ScrollWheelRight>   |  move window six columns right               | i_<ScrollWheelRight>    |
| <S-ScrollWheelRight> |  move window one page right                  | i_<S-ScrollWheelRight>  |
| CTRL-O               |  execute one command, return to Insert mode  | i_CTRL-O                |
| CTRL-\ CTRL-O        |  like CTRL-O but don't move the cursor       | i_CTRL-\_CTRL-O         |
| CTRL-G u             |  close undo sequence, start new change       | i_CTRL-G_u              |
| CTRL-G U             |  don't start a new undo block with the next  | i_CTRL-G_U              |
|                      |  left/right cursor movement, if the cursor   |                         |
|                      |  stays within the same line                  |                         |

}}} --]]

-- commented out {{{
-- [ '<C-S-e>'  ] = {F, '',                       '<C-e>'},
-- vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end)
-- vim.keymap.set('n', 'grr', function() vim.lsp.buf.references() end)
-- vim.keymap.set('n', '<C-m>', function() vim.diagnostic.open_float() end)
-- local status1 = '%t %r%m%=[%v] (%L lines) (%{wordcount().words} words)%=%#HLspStatus#%{LspStatus()}%*[%{LspStatus()}] [%F]'
-- { n,    '<C-|>',    F, 'Search icase exact',     '/\\V'},
-- { n,    '<C-_>',    F, '',                       '/\\v'},
-- { n,    '<Tab>',    F, '',                       ':earlier<CR>'},
-- { n,    '<S-Tab>',  F, '',                       ':later<CR>'},
-- { n,    '\\|',      F, '',                       '?\\V\\c'},
-- local _l = '<leader>'
-- { n, 'I'   ,  F, '+ lsp_lines',            ':lua require("lsp_lines").toggle()<CR>'},
-- [ '<C-p>'    ] = {F, 'Substitute',             '<C-i>'},
-- local l = 'l';
-- [ '<C-p>'    ] = {F, 'Substitute [All Buffs]', ':%s/\\v\\c'},
-- [ '<C-k>'    ] = {F, 'Delete to end of line',  '<C-g>u<C-o>D'},
-- CTRL-U   Delete all entered characters before the cursor in the current line.
-- [ '{'        ] = {F, 'Prev Function Start',    ':GotoPrevFunctionStart<CR>'},
-- [ '}'        ] = {F, 'Next Function Start',    ':GotoNextFunctionStart<CR>'},
-- [ 'S'       ] = { F, 'Source vim config',      ':source ~/.config/nvim/init.vim<ESC>'},
-- [ 'cp'      ] = { F, '! Rainbow Parenth',      ':RainbowToggle<CR>'},
-- [ 'W'       ] = { F, 'VimwikiIndex',           '<Plug>VimwikiIndex'},
-- Execute --
-- Session --
-- [ 'pP'      ] = { F, 'Paste as line above',    'k:put="a'},
-- [ 'pp'      ] = { F, 'Paste as line below',    ''},
-- [ '<C-h>'    ] = {F, 'Left Pane',              '<C-w>h'},
-- [ '<C-j>'    ] = {F, 'Down Pane',              '<C-w>j'},
-- [ '<C-k>'    ] = {F, 'Up Pane',                '<C-w>k'},
-- [ '<C-l>'    ] = {F, 'Right Pane',             '<C-w>l'},
-- }}}
