#!/usr/bin/lua

---@diagnostic disable: unused-local, unused-function

-- {{{
local function my_buffers()
  require("telescope.builtin").buffers({ignore_current_buffer=true, disable_coordinates = true, sort_mru=true, bufnr_width=0})
end

local function my_live_grep()
  require("telescope.builtin").live_grep({grep_open_files = true, disable_coordinates = true})
end
-- }}}

-- Remember:
-- innoremap <expr> key command
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
    X     = { desc='[execute] w/args',          default=':!%:p '},
    y     = { desc='[set] bg transparent',      cmd='hi Normal guibg=Transparent'},
    z     = { desc='',                          default='z'},
    ---[misc-special]
    [ '<C-s>'   ] = { desc='[spectre] sub buffs',  cmd='lua require("spectre").toggle()', },
    [ '<C-S-x>' ] = { desc='[execute] w/ args', default=':!%:p '},
    [ '<C-x>'   ] = { desc='[execute]',         default=':!%:p<ESC>'},
    [ '<S-Tab>' ] = { desc='later',             cmd='later'},
    [ '<Tab>'   ] = { desc='earlier',           cmd='earlier'},
    [ '.'       ] = { desc='next window',       cmd='keepalt wincmd w'},
    [ ','       ] = { desc='alternate file',    default='<C-^>'},
    [ '-'       ] = { desc='resize split -20',  default='20<c-w><'},
    [ '='       ] = { desc='resize split +20',  default='20<c-w>>'},
    [ '['       ] = { desc='prev buffer',       cmd='bprevious'},
    [ ']'       ] = { desc='next buffer',       cmd='bnext'},
    ---[group][reserved] filetype-specific
    A     = { group="filetype-specific" },
    ---[group] buffer
    B     = { group="buffer"},
    By    = { desc='[clip] buffer',             default='gg"+yG<c-o>'},
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
    Gc    = { desc='clear notifications',       lua_call='require("notify").dismiss({silent = true})'},
    Gh    = { desc='checkhealth',               cmd='checkhealth'},
    Gm    = { desc='messages',                  cmd='messages'},
    Gn    = { desc='notifications',             cmd='Notifications'},
    Gu    = { desc='get undo list',             cmd='undolist'},
    ---[group] help
    H     = { group="help"},
    Hg    = { desc='helpgrep',                    default=':vert helpgrep '},
    Hh    = { desc='[show] highlight',            default=GetHL},
    Hme   = { desc='[open] mappings file',        cmd='edit ' .. vim.g.mapping_file},
    Hmp   = { desc='[print] all mappings',        default=GetMappings},
    Ho    = { desc='[vim] options',               cmd='Telescope vim_options'},
    Hs    = { desc='[show-buffer] syntax items',  cmd='syntax'},
    Ht    = { desc='[vim] commands',              cmd='Telescope commands'},
    Hv    = { desc='[vim] help tags',             cmd='Telescope help_tags'},
    ---[group] lsp
    I     = { group="lsp"},
    IA    = { desc='[-] lsp',                   cmd='lsp stop'},
    Ia    = { desc='[+] lsp',                   cmd='lsp enable'}, -- this sucks need to find way to start only those defined by nvim lsp config
    Ir    = { desc='restart lsp',               cmd='lsp restart'},
    Ic    = { desc='[show] code-action',        default=require("actions-preview").code_actions},
    Id    = { desc='[goto] definition',         default=vim.lsp.buf.definition},
    Ihc   = { desc='[-highlight] symbol',       default=vim.lsp.buf.clear_references},
    Ihs   = { desc='[+highlight] symbol',       default=LspDocumentHighlight},
    Ii    = { desc='[show] diagnostics',        lua_call='vim.diagnostic.open_float(nil, {focus=T, scope="cursor"})'},
    Il    = { desc='[hover] lsp info',          lua_call='vim.lsp.buf.hover({max_height=30, max_width=30})'},
    In    = { desc='[goto] next error',         lua_call='vim.diagnostic.jump({count=1, float=true})'},
    Ip    = { desc='[goto] prev error',         lua_call='vim.diagnostic.goto_prev({count=-1, float=true})'},
    Iy    = { desc='[!]lsp_lines',              default=require("lsp_lines").toggle},
    ---[group] misc
    M     = { group="misc"},
    Mt    = { desc='new terminal',              cmd='term'},
    Mc    = { desc='set pwd to currfile',       cmd='cd %:p:h'},
    Me    = { desc='telescope',                 cmd='Telescope'},
    ---[group] open
    O     = { group="open"},
    Ob    = { desc='[open] buffers with extension', default=FZFBuffersWithExtension},
    OBb   = { desc='[open] w/ $BROWSER',        cmd='!"${BROWSER:-"brave"}"  %:p', silent=true},
    OBq   = { desc='[open] w/ qutebrowser',     cmd='!"qutebrowser" %:p', silent=true},
    ONb   = { desc='[open-new] buffer',         cmd='enew'},
    ONf   = { desc="[open] file",               cmd="Telescope find_files"},
    ONn   = { desc='[open-new] file',           cmd='enew'},
    Or    = { desc='[open] recent files',       cmd='Telescope oldfiles'},
    Ot    = { desc='[open-new] tab',            cmd='tabnew'},
    ---[group] execution
    S     = { group="execution"},
    SX    = { desc='[execute] w/ args',         default=':!%:p ',},
    Sl    = { desc='luafile',                   default=Bind(CMD.luafile, "%:p"),},
    Ss    = { desc='[source shell]',            default=Bind(CMD["!"], "source", "%:p"),},
    SS    = { desc='[source vim]',              default=CMD.source},
    Sx    = { desc='[execute]',                 default=Bind(CMD["!"], "%:p"), },
    ---[group] treesitter
    T     = { group="treesitter"},
    Tl    = { desc='[show] treesitter parser',  lua_call='vim.treesitter.get_parser(0):lang()', print=true},
    Ts    = { desc='[show] treesitter status',  lua_call='MyTreesitterStatus()', print=true},
    Tt    = { desc='[open] treesitter tree',    default=vim.treesitter.inspect_tree},
    ---[group] editor settings
    c     = { group="editor setting"},
    cA    = { desc='[off] autofold comments',   cmd='AutoFoldComments off'},
    cC    = { desc='[!]folds in gutter',        vim_call='TogFoldColumn()'},
    cJ    = { desc='[prev] scheme',             default=Bind(Cycle, "colors_name", vim.g.ColorSchemes, vim.cmd.colorscheme, {scope = "g", increment=-1}),},
    cL    = { desc='[next] statusline',         cmd='lua= Cycle("statusline", vim.g.my_statuslines)'},
    cS    = { desc='[!]spell',                  cmd='set spell!'},
    ca    = { desc='[on] autofold comments',    cmd='AutoFoldComments multi'},
    cc    = { desc='[!]line length indicator',  vim_call='TogColorColumn()'},
    ce    = { desc='[!]cursorcolumn',           cmd='set cuc!'},
    cf    = { desc='format',                    cmd='lua RunKeepCursorPosition( function() vim.cmd.Autoformat { mods={ verbose=1 } } end)',},
    cg    = { desc='[!]git signs',              cmd='Gitsigns toggle_linehl'},
    ch    = { desc='format2',                   default=vim.lsp.buf.format},
    cj    = { desc='[next] scheme',             default=Bind(Cycle, "colors_name", vim.g.ColorSchemes, vim.cmd.colorscheme, {scope = "g"}),},
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
} --
KeyMapSetter2(LEADER_MAPPINGS, "<leader>", false, true)
