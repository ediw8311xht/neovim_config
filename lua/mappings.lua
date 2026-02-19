#!/usr/bin/lua

local F = false;
local T = true;
local c = 'c';
local e = '';
local i = 'i';
local n = 'n';
local t = 't';
local v = 'v';
local current_file = vim.fn.expand('%:p')

-- Regular Mappings {{{
-- note to self: look into using `<cmd>` and `<expr>` more IGNORE
REGULAR_MAPPINGS={
  [e] = {
    [ '+'        ] = {T, 'End of line',            'g_'                                         },
    [ ','        ] = {T, '<leader>',               '<leader>'                                   },
    [ ',;'       ] = {F, '',                       ','                                          },
    [ 'x'        ] = {F, '',                       '"xx'                                        },
  }, [n] = {
    [ '/'        ] = {F, 'Search vmagic',          '/\\v\\c'                                    },
    [ '<C-S-E>'  ] = {F, 'End of previous word',   'ge'                                         },
    [ '<C-S-H>'  ] = {F, 'Left pane',              '<C-w>h'                                     },
    [ '<C-S-J>'  ] = {F, 'Down pane',              '<C-w>j'                                     },
    [ '<C-S-K>'  ] = {F, 'Up Pane',                '<C-w>k'                                     },
    [ '<C-S-L>'  ] = {F, 'Right pane',             '<C-w>l'                                     },
    [ '<C-S-Tab>'] = {F, 'Previous tab',           'tabprevious',                      cmd=true },
    [ '<C-S-g>'  ] = {F, '! Floating Term',        ':FloatermToggle!<ESC>'                      },
    [ '<C-S-s>'  ] = {F, 'Substitute +char +vmagic', ':%s/\\v'                                  },
    [ '<C-Tab>'  ] = {F, 'Next tab',               'tabnext',                          cmd=true },
    [ '<C-n>'    ] = {F, '+Nerd Tree',             'NERDTreeToggle',                   cmd=true },
    [ '<C-s>'    ] = {F, 'Substitute i',           ':%s/\\v\\c'                                 },
    [ '<C-w>n'   ] = {F, 'New Buffer Right',       ':new<ESC><C-w>L'                            },
    [ '<ESC>'    ] = {F, 'Clear',                  ':noh<ESC>:echon ""<enter>'                  },
    [ '?'        ] = {F, 'Search +back +vmagic',   '?\\v\\c'                                    },
    [ 'ZC'       ] = {F, 'Delete Buffer',          ':bd<ESC>'                                   },
    [ 'ZG'       ] = {F, 'Write quit all',         'wqall',                            cmd=true },
    [ '`'        ] = {F, 'Fold',                   '@=(foldlevel(\'.\')?\'za\':"<Space>")<CR>'  },
    [ 'gne'      ] = {F, 'Next Function End',      'GotoNextFunctionEnd',              cmd=true },
    [ '{'        ] = {F, 'Prev Function Start',    'GotoPrevFunctionStart',            cmd=true },
    [ '|'        ] = {F, 'Search nomagic',         '/\\V\\c'                                    },
    [ '}'        ] = {F, 'Next Function Start',    'GotoNextFunctionStart',            cmd=true },
  }, [t] = {
    [ '<C-w>'    ] = {T, 'Normal Mode',     '<C-\\><C-n>'                },
    [ '<C-S-g>'  ] = {T, '! Floating Term', '<C-w>:FloatermToggle!<ESC>' },
  }, [v] = {
    [ '<C-S-s>'  ] = {F, 'Sub +vmagic',            ':s/\\%V\\v'                                 },
    [ '<C-s>'    ] = {F, 'Sub +i +vmagic',         ':s/\\%V\\v\\c'                              },
    [ '`'        ] = {F, '',                       'zf'                                         },
  }, [i] = {
    [ 'jk'       ] = {F, 'Exit Insert[m]',                 '<ESC>'                              },
    [ '<C-u>'    ] = {F, 'Delete entered chars b4 cursor', '<C-g>u<C-u>'                        },
    [ '<C-S-b>'  ] = {F, 'Backward whole word',            '<C-o>B'                             },
    [ '<C-S-f>'  ] = {F, 'Forward whole word',             '<C-o>W'                             },
    [ '<C-S-g>'  ] = {F, 'New undo point',                 '<C-g>u'                             },
    [ '<C-S-k>'  ] = {F, 'Delete to end of line',          '<C-g>u<C-o>D'                       },
    [ '<C-S-t>'  ] = {F, 'Remove indent',                  '<C-d>'                              },
    [ '<C-S-u>a' ] = {F, 'New undo point',                 '<C-g>u'                             },
    [ '<C-S-u>r' ] = {F, 'Redo',                           '<C-o><C-r>'                         },
    [ '<C-S-u>u' ] = {F, 'Undo',                           '<C-o>u'                             },
  }, [c] = {
    [ '<C-S-k>'  ] = {F, '',                       '<C-c>D<C-c>'                                },
  }, [ {c, i} ] = {
    [ '<C-a>'    ] = {F, 'Start of line',          '<home>'                                     },
    [ '<C-b>'    ] = {F, 'Backward char',          '<left>'                                     },
    [ '<C-e>'    ] = {F, 'End of line',            '<end>'                                      },
    [ '<C-f>'    ] = {F, 'Forward char',           '<right>'                                    },
    [ '<C-w>'    ] = {F, 'Forward word',           '<S-right>'                                  },
    [ '<C-S-w>'  ] = {F, 'Backward word',          '<S-left>'                                   },
    [ '<C-BS>'   ] = {F, 'Delete word backwards',  '<C-w>'                                      },
-- [ '<C-S-e>'  ] = {F, '',                       '<C-e>'                                   },
  }, [ {n, v, t, i} ] = {
    [ "<C-1>" ] = { F, 'Go to tab 1',    "1gt"           },
    [ "<C-2>" ] = { F, 'Go to tab 2',    "2gt"           },
    [ "<C-3>" ] = { F, 'Go to tab 3',    "3gt"           },
    [ "<C-4>" ] = { F, 'Go to tab 4',    "4gt"           },
    [ "<C-5>" ] = { F, 'Go to tab 5',    "5gt"           },
    [ "<C-6>" ] = { F, 'Go to tab 6',    "6gt"           },
    [ "<C-7>" ] = { F, 'Go to tab 7',    "7gt"           },
    [ "<C-8>" ] = { F, 'Go to tab 8',    "8gt"           },
    [ "<C-9>" ] = { F, 'Go to last tab', ":tablast<CR>"  },
  },
} -- }}}

--[[ Leader Mappings {{{
---------- Remember -----------
-- inoremap <expr> key command
---------------------------------]]
LEADER_MAPPINGS = {
  [n] = {
    [ 'B' ]={group="buffer"},
    [ 'Bn'      ] = { F, 'New Buffer',             ':enew<ESC><enter>'  },
    [ 'Bd'      ] = { F, 'Delete Buffer',          ':bd<ESC><enter>'    },
    [ 'Bc'      ] = { F, 'Copy Buffer to Clip',    'gg"+yG<c-o>'        },
    [ 'F' ]={group="AutoSession"},
    [ 'Fss'     ] = { F, 'Session Save',           'AutoSession save',    cmd=true },
    [ 'Fa'      ] = { F, '! Session Auto Save',    'AutoSession toggle',  cmd=true },
    [ 'Fc'      ] = { F, 'Session Search',         'AutoSession search',  cmd=true },
    [ 'Fsa'     ] = { F, '[Args] Session Save',    ':AutoSession save '            },
    [ 'H' ]={group="Help/Docs"},
    [ 'Hm'      ] = { F, 'Print Mappings File',    'edit ' .. current_file,   cmd=true  },
    [ 'HM'      ] = { F, 'Print All Mappings',     'GMaps()',                 expr=true },
    [ 'Hu'      ] = { F, 'Get undo list',          'undolist',                cmd=true  },
    [ 'Hh'      ] = { F, 'Get Highlight',          'GetHL()',                 expr=true },
    [ 'I' ]={group="lsp"},
    [ 'Ia'      ] = { F, 'Start LSP',                 'LspStart',                                                      cmd=true  },
    [ 'IA'      ] = { F, 'Stop LSP',                  'LspStop',                                                       cmd=true  },
    [ 'Ic'      ] = { F, 'Show code-action',          'lua require("actions-preview").code_actions()',                 cmd=true  },
    [ 'Id'      ] = { F, 'Go to definition',          'lua vim.lsp.buf.definition()',                                  cmd=true  },
    [ 'Ihs'     ] = { F, 'Highlight Symbol',          'lua LspDocumentHighlight()',                                    cmd=true  },
    [ 'Ii'      ] = { F, 'Show diagnostics',          'lua vim.diagnostic.open_float(nil, {focus=T, scope="cursor"})', cmd=true  },
    [ 'Il'      ] = { F, 'hover lsp info',            'lua vim.lsp.buf.hover()',                                       cmd=true  },
    [ 'In'      ] = { F, 'Goto next error',           'lua vim.diagnostic.goto_next()',                                cmd=true  },
    [ 'Ip'      ] = { F, 'Goto prev error',           'lua vim.diagnostic.goto_prev()',                                cmd=true  },
    [ 'Ihc'     ] = { F, 'Clear Highlight Symbol',    'lua vim.lsp.buf.clear_references()',                            cmd=true  },
    [ 'Iy'      ] = { F, '! lsp_lines',               'lua require("lsp_lines").toggle()',                             cmd=true  },
    [ 'T' ]={group="treesitter"},
    [ 'Tl'      ] = { F, 'Get Treesitter Parser',       'lua= vim.treesitter.get_parser(0):lang()', cmd=true  },
    [ 'Tt'      ] = { F, 'Open Treesitter Tree',        'lua vim.treesitter.inspect_tree()',        cmd=true  },
    [ 'Ts'      ] = { F, 'Treesitter Status',           'lua= MyTreesitterStatus()',                cmd=true  },
    [ 'M' ]={group="misc"},
    [ 'MT'      ] = { F, 'New Terminal',                'term',      cmd=true  },
    [ 'Mc'      ] = { F, 'Set Dir to CWD of Open File', 'cd %:p:h',  cmd=true  },
    [ 'Me'      ] = { F, 'Telescope',                   'Telescope', cmd=true  },
    [ 'Mn'      ] = { F, 'New File',                    'enew',      cmd=true  },
    [ 'Mt'      ] = { F, 'New Tab',                     'tabnew',    cmd=true  },
    [ 'S' ]={group="execution"},
    [ 'SX'      ] = { F, 'Execute with args',      ':!%'                 },
    [ 'Sl'      ] = { F, 'Luafile',                'luafile %', cmd=true },
    [ 'Ss'      ] = { F, 'Source file',            '%so',       cmd=true },
    [ 'Sx'      ] = { F, 'Execute',                '!%',        cmd=true },
-- One Key -- 
    [ 'E'       ] = { F, 'CWD Edit',               'feedkeys(":e " . FilePathFull() . "/")',                    expr=true },
    [ 'W'       ] = { F, 'Write',                  ':w<ESC>'                                                              },
    [ 'b'       ] = { F, 'open buffer',            function() require("telescope.builtin").buffers({ignore_current_buffer=true, disable_coordinates = true}) end },
    [ 'cB'      ] = { F, 'Prev Background',        'CyBack(-1)',                                                expr=true },
    [ 'cC'      ] = { F, '! Folds in gutter',      'TogFoldColumn()',                                           expr=true },
    [ 'cF'      ] = { F, 'Format [Prettier]',      function() vim.lsp.buf.format() end                                    },
    [ 'cJ'      ] = { F, 'Prev Scheme',            'SetColScheme(-1)',                                          expr=true },
    [ 'cL'      ] = { F, 'Cycle Statusline',       'lua= Cycle("statusline", vim.g.my_statuslines)',            cmd=true  },
    [ 'cS'      ] = { F, '! Spell',                'set spell!',                                                cmd=true  },
    [ 'cb'      ] = { F, 'Next Background',        'CyBack(+1)',                                                expr=true },
    [ 'cc'      ] = { F, '! Line Length Indicator','TogColorColumn()',                                          expr=true },
    [ 'ce'      ] = { F, '! CursorColumn',         'set cuc!',                                                  cmd=true  },
    [ 'cf'      ] = { F, 'Format',                 'lua RunKeepCursorPosition(function() vim.cmd(":Autoformat") end)', cmd=true },
    [ 'cg'      ] = { F, '! Git Signs',            'Gitsigns toggle_linehl',                                    cmd=true  },
    [ 'cj'      ] = { F, 'Next Scheme',            'SetColScheme(+1)',                                          expr=true },
    [ 'ck'      ] = { F, 'CorrectColors()',        'lua CorrectColors()',                                       cmd=true  },
    [ 'cl'      ] = { F, '! CursorLine',           'lua ToggleHighlight({"CursorLine"})',                       cmd=true  },
    [ 'co'      ] = { F, 'Vim options',            'Telescope vim_options',                                     cmd=true  },
    [ 'cr'      ] = { F, '! Rainbow',              'rainbow_delimiters#toggle(0)',                              expr=true },
    [ 'cs'      ] = { F, '! Statusline',           'TogLastStatus()',                                           expr=true },
    [ 'cv'      ] = { F, '! Virtualedit',          'TogVirtualEdit()',                                          expr=true },
    [ 'cw'      ] = { F, '! Wrap',                 'set wrap!',                                                 cmd=true  },
    [ 'df'      ] = { F, 'Find Space EOL',         '%s/\\s\\+\\ze$//gc',                                        cmd=true  },
    [ 'grg'     ] = { F, 'Search in All Buffers',  function() require("telescope.builtin").live_grep({grep_open_files = true, disable_coordinates = true}) end },
    [ 'i'       ] = { F, 'Show diagnostics',       ':lua vim.diagnostic.open_float(nil, {focus=T, scope="cursor"})<ESC>'  },
    [ 'mH'      ] = { F, 'Helpgrep',               ':vert helpgrep '                                                      },
    [ 'mc'      ] = { F, 'Clear Notifications',    function() require("notify").dismiss({silent = true}) end              },
    [ 'mh'      ] = { F, 'Checkhealth',            'checkhealth',                                               cmd=true  },
    [ 'mm'      ] = { F, 'Messages',               'messages',                                                  cmd=true  },
    [ 'ob'      ] = { F, 'Open in Browser',        'silent !"${BROWSER:-"brave"}"  %',                          cmd=true  },
    [ 'oq'      ] = { F, 'Open in Qutebrowser',    'silent !"qutebrowser" %',                                   cmd=true  },
    [ 'or'      ] = { F, 'Recent files',           'Telescope oldfiles',                                        cmd=true  },
    [ 'q'       ] = { F, 'Delete buffer',          ':bd'                                                                  },
    [ 's'       ] = { F, 'Switch pane',            '<C-w><C-p>'                                                           },
    [ 'u'       ] = { F, 'lf file manager',        'Lf',                                                        cmd=true  },
    [ 'U'       ] = { F, 'lf cd',                  'Lfcd',                                                      cmd=true  },
    [ 'vt'      ] = { F, 'title case',             ':s/\\v\\c\\w(\\a*(\'\\a{0,1})?\\w)?/\\u\\0/g | nohl<CR>'              },
    [ 'wj'      ] = { F, 'Decrease Size Split',    '40<c-w><'                                                             },
    [ 'wk'      ] = { F, 'Increase Size Split',    '40<c-w>>'                                                             },
    [ 'wo'      ] = { F, 'Toggle Fullscreen',      'ToggleFullscreen',                                          cmd=true  },
    [ 'x'       ] = { F, 'Execute',                ':!%:p<ESC>'                                                           },
    [ 'y'       ] = { F, 'bg transparent',         ':hi Normal guibg=Transparent<ESC>'                                    },
    [ 'z'       ] = { F, '',                       'z'                                                                    },
    [ ','       ] = { F, 'Alternate File',         '<C-^>'                                                                },
    [ ']'       ] = { F, 'Next Buffer',            'bnext',                                                     cmd=true  },
    [ '['       ] = { F, 'Prev Buffer',            'bprevious',                                                 cmd=true  },
    [ '-'       ] = { F, 'Resize Split -20',       '20<c-w><'                                                             },
    [ '='       ] = { F, 'Resize Split +20',       '20<c-w>>'                                                             },
-- CTRL --
    [ '<C-S-x>' ] = { F, 'Execute with args',      ':!%:p '                                                               },
    [ '<C-s>'   ] = { F, 'Sub in all buffs',       ':budfo %s/\\v\\c'                                                     },
    [ '<C-x>'   ] = { F, 'Execute',                ':!%:p<ESC>'                                                           },
-- TAB --
    [ '<S-Tab>' ] = { F, 'Later',                  'later',                                                     cmd=true  },
    [ '<Tab>'   ] = { F, 'Earlier',                'earlier',                                                   cmd=true  },
  }, [v] = {
    [ 'vc'      ] = { F, 'column',                 ':%!column -o " " -t<ESC>',                                            },
    [ 'vmf'     ] = { F, 'bc [math] float',        ':!bc -l<ESC>'                                                         },
    [ 'vmi'     ] = { F, 'bc [math] int',          ':!bc -l<ESC>'                                                         },
    [ 'vmq'     ] = { F, 'qalc [math]',            ':!xargs qalc --color=never --terse<ESC>'                              },
    [ 'vs'      ] = { F, 'sort',                   ':sort<ESC>',                                                          },
    [ 'vt'      ] = { F, 'title case',             ':s/\\%V\\v\\c\\w(\\a*(\'\\a{0,1})?\\w)?/\\u\\0/g<CR>'                 },
  }
} -- }}}

PERSONAL_MAPPINGS = { ["regular"] = REGULAR_MAPPINGS, ["leader"] = LEADER_MAPPINGS }
KeyMapSetter(LEADER_MAPPINGS, "<leader>", false, true)
KeyMapSetter(REGULAR_MAPPINGS, "", false, true)

-- {{{
-- vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end)
-- vim.keymap.set('n', 'grr', function() vim.lsp.buf.references() end)
-- vim.keymap.set('n', '<C-m>', function() vim.diagnostic.open_float() end)
-- local status1 = '%t %r%m%=[%v] (%L lines) (%{wordcount().words} words)%=%#HLspStatus#%{LspStatus()}%*[%{LspStatus()}] [%F]'

-- { n,    '<C-|>',    F, 'Search icase exact',     '/\\V'                                       },
-- { n,    '<C-_>',    F, '',                       '/\\v'                                       },
-- { n,    '<Tab>',    F, '',                       ':earlier<CR>'                               },
-- { n,    '<S-Tab>',  F, '',                       ':later<CR>'                                 },
-- { n,    '\\|',      F, '',                       '?\\V\\c'                                    },
-- local _l = '<leader>'
-- { n, 'I'   ,  F, '+ lsp_lines',            ':lua require("lsp_lines").toggle()<CR>'                            },
-- [ '<C-p>'    ] = {F, 'Substitute',             '<C-i>'                                      },
-- local l = 'l';
-- [ '<C-p>'    ] = {F, 'Substitute [All Buffs]', ':%s/\\v\\c'                              },
-- [ '<C-k>'    ] = {F, 'Delete to end of line',  '<C-g>u<C-o>D'                               },
-- CTRL-U   Delete all entered characters before the cursor in the current line.
-- [ '{'        ] = {F, 'Prev Function Start',    ':GotoPrevFunctionStart<CR>'              },
-- [ '}'        ] = {F, 'Next Function Start',    ':GotoNextFunctionStart<CR>'              },
-- [ 'S'       ] = { F, 'Source vim config',      ':source ~/.config/nvim/init.vim<ESC>'                                 },
-- [ 'cp'      ] = { F, '! Rainbow Parenth',      ':RainbowToggle<CR>'                                                   },
-- [ 'W'       ] = { F, 'VimwikiIndex',           '<Plug>VimwikiIndex'                                                   },
-- Execute --
-- Session --
-- [ 'pP'      ] = { F, 'Paste as line above',    'k:put="a' },
-- [ 'pp'      ] = { F, 'Paste as line below',    '' },
-- [ '<C-h>'    ] = {F, 'Left Pane',              '<C-w>h'                                     },
-- [ '<C-j>'    ] = {F, 'Down Pane',              '<C-w>j'                                     },
-- [ '<C-k>'    ] = {F, 'Up Pane',                '<C-w>k'                                     },
-- [ '<C-l>'    ] = {F, 'Right Pane',             '<C-w>l'                                     },
-- }}}

--[[ {{{
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
{{{ --]]
