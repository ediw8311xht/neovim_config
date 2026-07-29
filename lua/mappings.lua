#!/usr/bin/lua

--[[
---@diagnostic disable: unused-local, unused-function
--]]

vim.g.mapping_file = vim.fs.joinpath(vim.g.dir_config .. "/lua/mappings.lua")
local function my_buffers()
  require("telescope.builtin").buffers({ignore_current_buffer=true, disable_coordinates = true, sort_mru=true})
end

local function my_live_grep()
  require("telescope.builtin").live_grep({grep_open_files = true, disable_coordinates = true})
end

function SubAllBuffers(x, y)
  local repl = vim.fn.printf(':%%s/\\v\\c%s/%s', x, y)
  vim.cmd.bufdo(
    repl
  )
end
-- sub_all_buffers(3, 3)
-- Leader Mappings {{{
---------- Remember -----------
-- innoremap <expr> key command
-------------------------------
LEADER_MAPPINGS = {
  n = {
    ---[misc]
    U     = { desc='[run] lf cd',               cmd='Lfcd'},
    W     = { desc='[buffer] write',            cmd='silent write | echom printf("file: \'%s\' - written: %s", expand("%:p"), strftime("%r"))'},
    b     = { desc='[switch] buffer',           default=my_buffers},
    df    = { desc='[search] space eol',        cmd='%s/\\s\\+\\ze$//gc'},
    grg   = { desc='[search] all buffers',      default=my_live_grep},
    -- grr   = { desc='[sub] all buffers',         default=":lua SubAllBuffers(" },
    i     = { desc='[show] diagnostics',        lua_call='vim.diagnostic.open_float(nil, {focus=T, scope="cursor"})'},
    s     = { desc='switch pane',               default='<C-w><C-p>'},
    u     = { desc='[run] lf',                  cmd='Lf'},
    vt    = { desc='title case',                cmd='s/\\v\\c\\w(\\a*(\'\\a{0,1})?\\w)?/\\u\\0/g | nohl'},
    wj    = { desc='[-]width',                  default='40<c-w><'},
    wk    = { desc='[+]width',                  default='40<c-w>>'},
    wo    = { desc='[!]fullscreen',             cmd='ToggleFullscreen'},
    x     = { desc='[execute]',                 cmd='!%:p'},
    y     = { desc='[set] bg transparent',      cmd='hi Normal guibg=Transparent'},
    z     = { desc='',                          default='z'},
    ---[misc-special]
    [ ','       ] = { desc='alternate file',    default='<C-^>'},
    [ '.'       ] = { desc='next window',       default=':keepalt wincmd w<CR>'},
    [ '-'       ] = { desc='resize split -20',  default='20<c-w><'},
    [ '<C-S-x>' ] = { desc='execute with args', default=':!%:p '},
    [ '<C-s>'   ] = { desc='sub in all buffs',  default=':budfo %s/\\v\\c'},
    [ '<C-x>'   ] = { desc='execute',           default=':!%:p<ESC>'},
    [ '<S-Tab>' ] = { desc='later',             cmd='later'},
    [ '<Tab>'   ] = { desc='earlier',           cmd='earlier'},
    [ '='       ] = { desc='resize split +20',  default='20<c-w>>'},
    [ '['       ] = { desc='prev buffer',       cmd='bprevious'},
    [ ']'       ] = { desc='next buffer',       cmd='bnext'},
    ---[group][reserved] filetype-specific
    A     = { group="filetype-specific" },
    ---[group] buffer
    B     = { group="buffer"},
    Bc    = { desc='[clip] buffer',             default='gg"+yG<c-o>'},
    Bd    = { desc='[-] buffer',                cmd='bd'},
    E     = { desc='cwd edit',                  lua_call='vim.fn.feedkeys(":e " .. GetFile({tilde_home=true, expand="%:p:h"}) .. "/")'},
    ---[group] AutoSession
    F     = { group="AutoSession"},
    Fa    = { desc='[!-session] auto save',     cmd='AutoSession toggle'},
    Fc    = { desc='[session] search',          cmd='AutoSession search'},
    Fsa   = { desc='[session-args] save',       default=':AutoSession save '},
    Fss   = { desc='[session] save',            cmd='AutoSession save'},
    ---[group] messages
    G     = { group="messages"},
    Gc    = { desc='clear notifications',       lua_call='require("notify").dismiss({silent = true})' },
    Gh    = { desc='checkhealth',               cmd='checkhealth'},
    Gm    = { desc='messages',                  cmd='messages'},
    Gn    = { desc='notifications',             cmd='Notifications'},
    Gu    = { desc='get undo list',             cmd='undolist'},
    ---[group] help
    H     = { group="help"},
    Hg    = { desc='helpgrep',                  default=':vert helpgrep '},
    Hh    = { desc='[show] highlight',          default=GetHL },
    Hk    = { desc='vim help tags',             cmd='Telescope help_tags'},
    Hme   = { desc='[open] mappings file',      cmd='edit ' .. vim.g.mapping_file},
    Hmp   = { desc='[print] all mappings',      default=GetMappings },
    Ho    = { desc='[vim] options',             cmd='Telescope vim_options'},
    Ht    = { desc='[vim] commands',            cmd='Telescope commands'},
    Hs    = { desc='[show-buffer] syntax items', cmd='syntax'},
    ---[group] lsp
    I     = { group="lsp"},
    IA    = { desc='[-] lsp',                   cmd='lsp stop'},
    Ia    = { desc='[+] lsp',                   cmd='lsp enable'}, -- this sucks need to find way to start only those defined by nvim lsp config
    Ir    = { desc='restart lsp',               cmd='lsp restart'},
    Ic    = { desc='[show] code-action',        default=require("actions-preview").code_actions },
    Id    = { desc='[goto] definition',         default=vim.lsp.buf.definition },
    Ihc   = { desc='[-highlight] symbol',       default=vim.lsp.buf.clear_references },
    Ihs   = { desc='[+highlight] symbol',       default=LspDocumentHighlight },
    Ii    = { desc='[show] diagnostics',        lua_call='vim.diagnostic.open_float(nil, {focus=T, scope="cursor"})'},
    Il    = { desc='[hover] lsp info',          lua_call='vim.lsp.buf.hover({max_height=30, max_width=30})'},
    In    = { desc='[goto] next error',         lua_call='vim.diagnostic.jump({count=1, float=true})'},
    Ip    = { desc='[goto] prev error',         lua_call='vim.diagnostic.goto_prev({count=-1, float=true})'},
    Iy    = { desc='[!]lsp_lines',              default=require("lsp_lines").toggle },
    ---[group] misc
    M     = { group="misc"},
    Mt    = { desc='new terminal',              cmd='term'},
    Mc    = { desc='set pwd to currfile',       cmd='cd %:p:h'},
    Me    = { desc='telescope',                 cmd='Telescope'},
    ---[group] open
    O     = { group="open"},
    Ob    = { desc='[open] buffers with extension', default=FZFBuffersWithExtension },
    OBb   = { desc='[open] w/ $BROWSER',        cmd='silent !"${BROWSER:-"brave"}"  %:p'},
    OBq   = { desc='[open] w/ qutebrowser',     cmd='silent !"qutebrowser" %:p'},
    ONb   = { desc='[open-new] buffer',         cmd='enew'},
    ONf   = { desc="[open] file",               cmd="Telescope find_files" },
    ONn   = { desc='[open-new] file',           cmd='enew'},
    Or    = { desc='[open] recent files',       cmd='Telescope oldfiles'},
    Ot    = { desc='[open-new] tab',            cmd='tabnew'},
    ---[group] execution
    S     = { group="execution"},
    SX    = { desc='[execute] w/ args',         default=':!%:p'},
    Sl    = { desc='luafile',                   cmd='luafile %:p'},
    Ss    = { desc='[source] current file',     cmd='%so'},
    Sx    = { desc='[execute]',                 cmd='!%:p'},
    ---[group] treesitter
    T     = { group="treesitter"},
    Tl    = { desc='[show] treesitter parser',  lua_call='vim.treesitter.get_parser(0):lang()', print=true},
    Ts    = { desc='[show] treesitter status',  lua_call='MyTreesitterStatus()', print=true},
    Tt    = { desc='[open] treesitter tree',    default=vim.treesitter.inspect_tree },
    ---[group] editor settings
    c     = { group="editor setting"},
    cA    = { desc='[off] autofold comments',   cmd='AutoFoldComments off'},
    cB    = { desc='[prev] background',         vim_call='CyBack(-1)'},
    cC    = { desc='[!]folds in gutter',        vim_call='TogFoldColumn()'},
    cJ    = { desc='[prev] scheme',             vim_call='SetColScheme(-1)'},
    cL    = { desc='[next] statusline',         cmd='lua= Cycle("statusline", vim.g.my_statuslines)'},
    cS    = { desc='[!]spell',                  cmd='set spell!'},
    ca    = { desc='[on] autofold comments',    cmd='AutoFoldComments multi'},
    cb    = { desc='[next] background',         vim_call='CyBack(+1)'},
    cc    = { desc='[!]line length indicator',  vim_call='TogColorColumn()'},
    ce    = { desc='[!]cursorcolumn',           cmd='set cuc!'},
    cf    = { desc='format',                    cmd='lua RunKeepCursorPosition(function() vim.cmd(":Autoformat") end)'},
    cg    = { desc='[!]git signs',              cmd='Gitsigns toggle_linehl'},
    ch    = { desc='format2',                   default=vim.lsp.buf.format },
    cj    = { desc='[next] scheme',             vim_call='SetColScheme(+1)'},
    ck    = { desc='correctcolors()',           cmd='lua CorrectColors()'},
    cl    = { desc='[!]cursorline',             cmd='lua ToggleHighlight({"CursorLine"})'},
    cr    = { desc='[!]rainbow',                vim_call='rainbow_delimiters#toggle(0)'},
    cs    = { desc='[!]statusline',             vim_call='TogLastStatus()'},
    cv    = { desc='[!]virtualedit',            vim_call='TogVirtualEdit()'},
    cw    = { desc='[!]wrap',                   cmd='set wrap!'},
  },
  v = {
    vc     = { desc='[indent] column',  default=':%!column -o " " -t<ESC>'},
    vmf    = { desc='[match] bc float', default=':!bc -l<ESC>'},
    vmi    = { desc='[match] bc int',   default=':!bc -l<ESC>'},
    vmq    = { desc='[match] qalc',     default=':!xargs qalc --color=never --terse<ESC>'},
    vs     = { desc='[sort]',           default=':sort<ESC>',},
    vt     = { desc='title case',       default=':s/\\%V\\v\\c\\w(\\a*(\'\\a{0,1})?\\w)?/\\u\\0/g<CR>'},
    -- vx     = { desc='execute selection',      'lua
  },
  [ { "v", "n" } ] = { }
} --}}}
KeyMapSetter2(LEADER_MAPPINGS, "<leader>", false,true)

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
-- { n,    '<C-|>',    'Search icase exact',     '/\\V'},
-- { n,    '<C-_>',    '',                       '/\\v'},
-- { n,    '<Tab>',    '',                       ':earlier<CR>'},
-- { n,    '<S-Tab>',  '',                       ':later<CR>'},
-- { n,    '\\|',      '',                       '?\\V\\c'},
-- local _l = '<leader>'
-- { n, 'I'   ,  '+ lsp_lines',            ':lua require("lsp_lines").toggle()<CR>'},
-- [ '<C-p>'    ] = {F, 'Substitute',             '<C-i>'},
-- local l = 'l';
-- [ '<C-p>'    ] = {F, 'Substitute [All Buffs]', ':%s/\\v\\c'},
-- [ '<C-k>'    ] = {F, 'Delete to end of line',  '<C-g>u<C-o>D'},
-- CTRL-U   Delete all entered characters before the cursor in the current line.
-- [ '{'        ] = {F, 'Prev Function Start',    ':GotoPrevFunctionStart<CR>'},
-- [ '}'        ] = {F, 'Next Function Start',    ':GotoNextFunctionStart<CR>'},
-- [ 'S'       ] = { desc='Source vim config',      ':source ~/.config/nvim/init.vim<ESC>'},
-- [ 'cp'      ] = { desc='! Rainbow Parenth',      ':RainbowToggle<CR>'},
-- [ 'W'       ] = { desc='VimwikiIndex',           '<Plug>VimwikiIndex'},
-- Execute --
-- Session --
-- [ 'pP'      ] = { desc='Paste as line above',    'k:put="a'},
-- [ 'pp'      ] = { desc='Paste as line below',    ''},
-- [ '<C-h>'    ] = {F, 'Left Pane',              '<C-w>h'},
-- [ '<C-j>'    ] = {F, 'Down Pane',              '<C-w>j'},
-- [ '<C-k>'    ] = {F, 'Up Pane',                '<C-w>k'},
-- [ '<C-l>'    ] = {F, 'Right Pane',             '<C-w>l'},
-- }}}
