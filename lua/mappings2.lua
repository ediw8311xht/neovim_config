#!/usr/bin/lua

--
--  _____________________________________________________________________________
--  ||                                                                         ||
--  ||                                                         [*map-table*]   ||
--  ||            Mode  | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang |   ||
--  ||   Command        +------+-----+-----+-----+-----+-----+------+------+   ||
--  ||   [nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |   ||
--  ||   n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |   ||
--  ||   [nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |   ||
--  ||   i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |   ||
--  ||   c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |   ||
--  ||   v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |   ||
--  ||   x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |   ||
--  ||   s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |   ||
--  ||   o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |   ||
--  ||   t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |   ||
--  ||   l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |   ||
--  ||_________________________________________________________________________||
--  ||                                                                         ||
--  ||   1.4 LISTING MAPPINGS                                [*map-listing*]   ||
--  ||                                                                         ||
--  ||   When listing mappings the characters in the first two columns are:    ||
--  ||                                                                         ||
--  ||    CHAR     MODE                                                        ||
--  ||   <Space>   Normal, Visual, Select and Operator-pending                 ||
--  ||      n      Normal                                                      ||
--  ||      v      Visual and Select                                           ||
--  ||      s      Select                                                      ||
--  ||      x      Visual                                                      ||
--  ||      o      Operator-pending                                            ||
--  ||      !      Insert and Command-line                                     ||
--  ||      i      Insert                                                      ||
--  ||      l      ":lmap" mappings for Insert, Command-line and Lang-Arg      ||
--  ||      c      Command-line                                                ||
--  ||      t      Terminal-Job                                                ||
--  ||-------------------------------------------------------------------------||
--  || mode([{expr}])                                             [*mode()*]   ||
--  ||_________________________________________________________________________||________
--  ||    n         | Normal                                                           ||
--  ||    no        | Op-pending                                                       ||
--  ||    nov       | Op-pending (forced charwise |o_v|)                               ||
--  ||    noV       | Op-pending (forced linewise |o_V|)                               ||
--  ||    noCTRL-V  | Op-pending (forced blockwise |o_CTRL-V|) CTRL-V is one character ||
--  ||    niI       | Normal using |i_CTRL-O| in |Insert-mode|                         ||
--  ||    niR       | Normal using |i_CTRL-O| in |Replace-mode|                        ||
--  ||    niV       | Normal using |i_CTRL-O| in |Virtual-Replace-mode|                ||
--  ||    nt        | Normal in |terminal-emulator| (insert goes to Terminal mode)     ||
--  ||    ntT       | Normal using |t_CTRL-\_CTRL-O| in |Terminal-mode|                ||
--  ||    v         | Visual by character                                              ||
--  ||    vs        | Visual by character using |v_CTRL-O| in Select mode              ||
--  ||    V         | Visual by line                                                   ||
--  ||    Vs        | Visual by line using |v_CTRL-O| in Select mode                   ||
--  ||    CTRL-V    | Visual blockwise                                                 ||
--  ||    CTRL-Vs   | Visual blockwise using |v_CTRL-O| in Select mode                 ||
--  ||    s         | Select by character                                              ||
--  ||    S         | Select by line                                                   ||
--  ||    CTRL-S    | Select blockwise                                                 ||
--  ||    i         | Insert                                                           ||
--  ||    ic        | Insert mode completion |compl-generic|                           ||
--  ||    ix        | Insert mode |i_CTRL-X| completion                                ||
--  ||    R         | Replace |R|                                                      ||
--  ||    Rc        | Replace mode completion |compl-generic|                          ||
--  ||    Rx        | Replace mode |i_CTRL-X| completion                               ||
--  ||    Rv        | Virtual Replace |gR|                                             ||
--  ||    Rvc       | Virtual Replace mode completion |compl-generic|                  ||
--  ||    Rvx       | Virtual Replace mode |i_CTRL-X| completion                       ||
--  ||    c         | Command-line editing                                             ||
--  ||    cr        | Command-line editing overstrike mode |c_<Insert>|                ||
--  ||    cv        | Vim Ex mode |gQ|                                                 ||
--  ||    cvr       | Vim Ex mode while in overstrike mode |c_<Insert>|                ||
--  ||    r         | Hit-enter prompt                                                 ||
--  ||    rm        | The -- more -- prompt                                            ||
--  ||    r?        | A |:confirm| query of some sort                                  ||
--  ||    !         | Shell or external command is executing                           ||
--  ||    t         | Terminal mode: keys go to the job                                ||
--  ||_________________________________________________________________________________||
local F = false;
local T = true;
local c = 'c';
local e = '';
local i = 'i';
local n = 'n';
local t = 't';
local v = 'v';

-- note to self: look into using `<cmd>` and `<expr>` more IGNORE
REGULAR_MAPPINGS={
  [e] = {
    [ '+'        ] = { val='g_',  remap=true, desc='End of line',                                                        },
    [ ','        ] = { val='<leader>',  remap=true, desc='<leader>',                                                     },
    [ ',;'       ] = { val=',',  desc='',                                                                    },
    [ 'x'        ] = { val='"xx',  desc='',                                                                  },
  }, [n] = {
    [ '/'        ] = { val='/\\v\\c',  desc='Search vmagic',                                                 },
    [ '<C-S-E>'  ] = { val='ge',  desc='End of previous word',                                               },
    [ '<C-S-H>'  ] = { val='<C-w>h',  desc='Left pane',                                                      },
    [ '<C-S-J>'  ] = { val='<C-w>j',  desc='Down pane',                                                      },
    [ '<C-S-K>'  ] = { val='<C-w>k',  desc='Up Pane',                                                        },
    [ '<C-S-L>'  ] = { val='<C-w>l',  desc='Right pane',                                                     },
    [ '<C-S-Tab>'] = { val=':tabprevious<CR>',  desc='Previous tab',                                         },
    [ '<C-S-s>'  ] = { val=':%s/\\v',  desc='Substitute +char +vmagic',                                      },
    [ '<C-Tab>'  ] = { val=':tabnext<CR>',  desc='Next tab',                                                 },
    [ '<C-n>'    ] = { val=':NERDTreeToggle<CR>',  desc='+Nerd Tree',                                        },
    [ '<C-s>'    ] = { val=':%s/\\v\\c',  desc='Substitute i',                                               },
    [ '<C-w>n'   ] = { val=':new<ESC><C-w>L',  desc='New Buffer Right',                                      },
    [ '<ESC>'    ] = { val=':noh<ESC>:echon ""<enter>',  desc='Clear',                                       },
    [ '?'        ] = { val='?\\v\\c',  desc='Search +back +vmagic',                                          },
    [ 'ZG'       ] = { val=':wqall<CR>',  desc='Write quit all',                                             },
    [ '`'        ] = { val='@=(foldlevel(\'.\')?\'za\':"<Space>")<CR>',  desc='Fold',                        },
    [ '|'        ] = { val='/\\V\\c',  desc='Search nomagic',                                                },
    [ '{ '       ] = { val=':GotoPrevFunctionStart<CR>',  desc='Prev Function Start',                        },
    [ '}'        ] = { val=':GotoNextFunctionStart<CR>',  desc='Next Function Start',                        },
    [ 'gne'      ] = { val=':GotoNextFunctionEnd<CR>',  desc='Next Function End',                            },
    [ '<C-S-g>'  ] = { val=':FloatermToggle!<ESC>',  desc='! Floating Term',                                 },
    [ 'ZC'       ] = { val=':bd<ESC>',  desc='Delete Buffer',                                                },
  }, [t] = {
    [ '<C-w>'    ] = { val='<C-\\><C-n>',  remap=true, desc='Normal Mode Terminal',                                      },
    [ '<C-S-g>'  ] = { val='<C-w>:FloatermToggle!<ESC>',  remap=true, desc='! Floating Term',                            },
  }, [v] = {
    [ '<C-S-s>'  ] = { val=':s/\\%V\\v',  desc='Sub +vmagic',                                                },
    [ '<C-s>'    ] = { val=':s/\\%V\\v\\c',  desc='Sub +i +vmagic',                                          },
    [ '`'        ] = { val='zf',  desc='',                                                                   },
  }, [i] = {
    [ 'jk'       ] = { val='<ESC>',  desc='Exit Insert[m]',                                                  },
    [ '<C-u>'    ] = { val='<C-g>u<C-u>',  desc='Delete entered chars b4 cursor',                            },
    [ '<C-S-b>'  ] = { val='<C-o>B',  desc='Backward whole word',                                            },
    [ '<C-S-f>'  ] = { val='<C-o>W',  desc='Forward whole word',                                             },
    [ '<C-S-g>'  ] = { val='<C-g>u',  desc='New undo point',                                                 },
    [ '<C-S-k>'  ] = { val='<C-g>u<C-o>D',  desc='Delete to end of line',                                    },
    [ '<C-S-t>'  ] = { val='<C-d>',  desc='Remove indent',                                                   },
    [ '<C-S-u>a' ] = { val='<C-g>u',  desc='New undo point',                                                 },
    [ '<C-S-u>r' ] = { val='<C-o><C-r>',  desc='Redo',                                                       },
    [ '<C-S-u>u' ] = { val='<C-o>u',  desc='Undo',                                                           },
  }, [c] = {
    [ '<C-S-k>'  ] = { val='<C-c>D<C-c>',  desc='',                                                          },
  }, [ {c, i} ] = {
    [ '<C-a>'    ] = { val='<home>',  desc='Start of line',                                                  },
    [ '<C-b>'    ] = { val='<left>',  desc='Backward char',                                                  },
    [ '<C-e>'    ] = { val='<end>',  desc='End of line',                                                     },
    [ '<C-f>'    ] = { val='<right>',  desc='Forward char',                                                  },
    [ '<C-w>'    ] = { val='<S-right>',  desc='Forward word',                                                },
    [ '<C-S-w>'  ] = { val='<S-left>',  desc='Backward word',                                                },
    [ '<C-BS>'   ] = { val='<C-w>',  desc='Delete word backwards',                                           },
    -- [ '<C-S-e>'  ] = { val='<C-e>',  desc='',                                                             },
  }, [ {n, v, t, i} ] = {
    [ "<C-1>" ] = { val="1gt",  desc='Go to tab 1',                  },
    [ "<C-2>" ] = { val="2gt",  desc='Go to tab 2',                  },
    [ "<C-3>" ] = { val="3gt",  desc='Go to tab 3',                  },
    [ "<C-4>" ] = { val="4gt",  desc='Go to tab 4',                  },
    [ "<C-5>" ] = { val="5gt",  desc='Go to tab 5',                  },
    [ "<C-6>" ] = { val="6gt",  desc='Go to tab 6',                  },
    [ "<C-7>" ] = { val="7gt",  desc='Go to tab 7',                  },
    [ "<C-8>" ] = { val="8gt",  desc='Go to tab 8',                  },
    [ "<C-9>" ] = { val=":tablast<CR>",  desc='Go to last tab',      },
  },
}

---------- Remember -----------
-- inoremap <expr> key command
-------------------------------
-- beginning

local LEADER_MAPPINGS={
  [n] = {
    [ 'Cb' ] = { val='gg"+yG<c-o>',  desc='Copy Buffer to Clip',                                                                 },
    [ 'D'  ] = { val=':bd<ESC><enter>',  desc='Delete Buffer',                                                                   },
    [ 'E'  ] = { val='feedkeys(":e " . FilePathFull() . "/")',  desc='CWD Edit',                     expr=true                  },
    [ 'FS' ] = { val=':AutoSession save<CR>',  desc='Session Save',                                                              },
    [ 'Fa' ] = { val=':AutoSession toggle<CR>',  desc='! Session Auto Save',                                                     },
    [ 'Fc' ] = { val=':AutoSession search<CR>',  desc='Session Search',                                                          },
    [ 'Fs' ] = { val=':AutoSession save ',  desc='[Args] Session Save',                                                          },
    [ 'IN' ] = { val='lua vim.diagnostic.goto_prev()',  desc='Goto prev error',                             cmd=true            },
    [ 'Ic' ] = { val='lua require("actions-preview").code_actions()',  desc='Show code-action',              cmd=true           },
    [ 'Ii' ] = { val='lua vim.diagnostic.open_float(nil, {focus=T, scope="cursor"})',  desc='Show diagnostics',  cmd=true          },
    [ 'Il' ] = { val='lua vim.lsp.buf.hover()',  desc='hover lsp info',                                    cmd=true             },
    [ 'In' ] = { val='lua vim.diagnostic.goto_next()',  desc='Goto next error',                             cmd=true            },
    [ 'Ip' ] = { val='lua vim.diagnostic.goto_prev()',  desc='Goto prev error',                             cmd=true            },
    [ 'Ih' ] = { val='lua LspDocumentHighlight()',  desc='Highlight Symbol',                                 cmd=true           },
    [ 'Id' ] = { val='lua vim.lsp.buf.definition()',  desc='Go to definition',                               cmd=true           },
    [ 'IH' ] = { val=':lua vim.lsp.buf.clear_references()<ESC>',  desc='Clear Lsp Highlight Symbol',                             },
    [ 'SX' ] = { val=':!%',  desc='Execute with args',                                                                           },
    [ 'Sl' ] = { val=':luafile %<CR>',  desc='Luafile',                                                                          },
    [ 'Ss' ] = { val=':%so<CR>',  desc='Source file',                                                                            },
    [ 'Sx' ] = { val=':!%<CR>',  desc='Execute',                                                                                 },
    [ 'Te' ] = { val=':Telescope<CR>',  desc='Telescope',                                                                        },
    [ 'Tn' ] = { val=':tabnew<ESC>',  desc='New Tab',                                                                            },
    [ 'Tt' ] = { val=':term<ESC>',  desc='Terminal',                                                                             },
    [ 'W'  ] = { val=':w<ESC>',  desc='Write',                                                                                   },
    [ 'b'  ] = { val=':Buffers<ESC>',  desc='open buffer',                                                                       },
    [ 'cA' ] = { val=':LspStart()<CR>',  desc='Start LSP',                                                                       },
    [ 'cB' ] = { val='CyBack(-1)',  desc='Prev Background',                                                 expr=true           },
    [ 'cC' ] = { val='TogFoldColumn()',  desc='! Folds in gutter',                                            expr=true         },
    [ 'cF' ] = { val=function() vim.lsp.buf.format() end,  desc='Format [Prettier]',                                             },
    [ 'cJ' ] = { val='SetColScheme(-1)',  desc='Prev Scheme',                                           expr=true               },
    [ 'cL' ] = { val=':lua = Cycle("statusline", vim.g.my_statuslines)<CR>',  desc='Cycle Statusline',                           },
    [ 'cS' ] = { val=':set spell!<CR>',  desc='! Spell',                                                                         },
    [ 'cV' ] = { val=':lua require("lsp_lines").toggle()<CR>',  desc='! lsp_lines',                                              },
    [ 'ca' ] = { val=':LspStop<CR>',  desc='Stop LSP',                                                                           },
    [ 'cb' ] = { val='CyBack(+1)',  desc='Next Background',                                                 expr=true           },
    [ 'cc' ] = { val='TogColorColumn()',  desc='! Line Length Indicator',                                           expr=true   },
    [ 'ce' ] = { val=':set cuc!<CR>',  desc='! CursorColumn',                                                                    },
    [ 'cf' ] = { val=function() RunKeepCursorPosition(function() vim.cmd(":Autoformat") end) end,  desc='Format',                        },
    [ 'cg' ] = { val='Gitsigns toggle_linehl',  desc='! Git Signs',                                     cmd=true                },
    [ 'cj' ] = { val='SetColScheme(+1)',  desc='Next Scheme',                                           expr=true               },
    [ 'ck' ] = { val=':lua CorrectColors()<CR>',  desc='CorrectColors()',                                                        },
    [ 'cl' ] = { val=':lua ToggleHighlight({"CursorLine"})<CR>',  desc='! CursorLine',                                           },
    [ 'co' ] = { val=':Telescope vim_options<CR>',  desc='Vim options',                                                          },
    [ 'cr' ] = { val='rainbow_delimiters#toggle(0)',  desc='! Rainbow',                               expr=true                 },
    [ 'cs' ] = { val='TogLastStatus()',  desc='! Statusline',                                            expr=true              },
    [ 'cv' ] = { val='TogVirtualEdit()',  desc='! Virtualedit',                                           expr=true             },
    [ 'cw' ] = { val=':set wrap!<ESC>',  desc='! Wrap',                                                                          },
    [ 'df' ] = { val=':%s/\\s\\+\\ze$//gc<CR>',  desc='Find Space EOL',                                                          },
    [ 'gu' ] = { val='undolist',  desc='Get undo list',                                                   cmd=true              },
    [ 'gh' ] = { val='GetHL()',  desc='Get Highlight',                                                    expr=true             },
    [ 'gm' ] = { val=':call GMaps()',  desc='Print Mappings',                                              cmd=true             },
    [ 'gn' ] = { val=':enew<ESC>',  desc='New File',                                                                             },
    [ 'grg'] = { val=function() require("telescope.builtin").live_grep({grep_open_files = true}) end,  desc='Search in All Buffers',      },
    [ 'i'  ] = { val=':lua vim.diagnostic.open_float(nil, {focus=T, scope="cursor"})<ESC>',  desc='Show diagnostics',            },
    [ 'mH' ] = { val=':vert helpgrep ',  desc='Helpgrep',                                                                        },
    [ 'mc' ] = { val=function() require("notify").dismiss({silent = true}) end,  desc='Clear Notifications',                     },
    [ 'mh' ] = { val=':checkhealth<CR>',  desc='Checkhealth',                                                                    },
    [ 'mm' ] = { val=':messages<ESC>',  desc='Messages',                                                                         },
    [ 'ob' ] = { val=':silent !"${BROWSER:-"brave"}"  %<CR>',  desc='Open in Browser',                                           },
    [ 'oq' ] = { val=':silent !"qutebrowser" %<CR>',  desc='Open in Qutebrowser',                                                },
    [ 'or' ] = { val=':Telescope oldfiles<CR>',  desc='Recent files',                                                            },
    [ 'q'  ] = { val=':bd',  desc='Delete buffer',                                                                               },
    [ 's'  ] = { val='<C-w><C-p>',  desc='Switch pane',                                                                          },
    [ 'u'  ] = { val='Lf',  desc='lf file manager',                                                          cmd=true           },
    [ 'U'  ] = { val='Lfcd',  desc='lf cd',                                                        cmd=true                     },
    [ 'vt' ] = { val=':s/\\v\\c\\w(\\a*(\'\\a{0,1})?\\w)?/\\u\\0/g | nohl<CR>',  desc='title case',                              },
    [ 'wj' ] = { val='40<c-w><',  desc='Decrease Size Split',                                                                    },
    [ 'wk' ] = { val='40<c-w>>',  desc='Increase Size Split',                                                                    },
    [ 'wo' ] = { val=':ToggleFullscreen<CR>',  desc='Toggle Fullscreen',                                                         },
    [ 'x'  ] = { val=':!%:p<ESC>',  desc='Execute',                                                                              },
    [ 'y'  ] = { val=':hi Normal guibg=Transparent<ESC>',  desc='bg transparent',                                                },
    [ 'z'  ] = { val='z',  desc='',                                                                                              },
    [ ','  ] = { val='<C-^>',  desc='Alternate File',                                                                            },
    [ ']'  ] = { val='bnext',  desc='Next Buffer',                                                       cmd=true               },
    [ '['  ] = { val='bprevious',  desc='Prev Buffer',                                                   cmd=true               },
    [ '-'  ] = { val='20<c-w><',  desc='Resize Split -20',                                                                       },
    [ '='  ] = { val='20<c-w>>',  desc='Resize Split +20',                                                                       },
    [ '<C-S-x>' ] = { val=':!%:p ',             desc='Execute with args',                                                                        },
    [ '<C-s>'   ] = { val=':budfo %s/\\v\\c',  desc='Sub in all buffs',                                                               },
    [ '<C-x>'   ] = { val=':!%:p<ESC>',  desc='Execute',                                                                              },
    [ '<S-Tab>' ] = { val=':later<CR>',  desc='Later',                                                                                },
    [ '<Tab>'   ] = { val=':earlier<CR>',  desc='Earlier',                                                                            }
  }, [v] = {
    [ 'vmf'     ] = { val=':!bc -l<ESC>',  desc='bc [math] float',                                                                    },
    [ 'vmi'     ] = { val=':!bc -l<ESC>',  desc='bc [math] int',                                                                      },
    [ 'vmq'     ] = { val=':!xargs qalc --color=never --terse<ESC>',  desc='qalc [math]',                                             },
    [ 'vc'      ] = { val=':!column -o " " -t<enter>',  desc='column',                                                                },
    [ 'vs'      ] = { val=':sort<enter>',  desc='sort',                                                                               },
    [ 'vt'      ] = { val=':s/\\%V\\v\\c\\w(\\a*(\'\\a{0,1})?\\w)?/\\u\\0/g<CR>',  desc='title case',                                 },
  }
}

PERSONAL_MAPPINGS = { ["regular"] = REGULAR_MAPPINGS, ["leader"] = LEADER_MAPPINGS }
KeyMapSetter(LEADER_MAPPINGS, "<leader>", false, true)
KeyMapSetter(REGULAR_MAPPINGS, "", false, true)
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
-- [ '<C-p>'    ] = { '<C-i>',  desc='Substitute',                                                      }


-- local l = 'l';
-- [ '<C-p>'    ] = { ':%s/\\v\\c',  desc='Substitute [All Buffs]',                                  }
    -- [ '<C-k>'    ] = { '<C-g>u<C-o>D',  desc='Delete to end of line',                                    }
    -- CTRL-U   Delete all entered characters before the cursor in the current line.
    -- [ '{ ':GotoPrevFunctionStart<CR>', '        ] = { desc='Prev Function Start',                     }
    -- [ '}'        ] = { ':GotoNextFunctionStart<CR>',  desc='Next Function Start',                     }
    -- [ 'S'       ] = { ':source ~/.config/nvim/init.vim<ESC>',  desc='Source vim config',                                          }
    -- [ 'cp'      ] = { ':RainbowToggle<CR>',  desc='! Rainbow Parenth',                                                            }
    -- [ 'W'       ] = { '<Plug>VimwikiIndex',  desc='VimwikiIndex',                                                                 }
    -- Execute --
    -- Session --
    -- [ 'pP'      ] = { 'k:put="a',  desc='Paste as line above',        }
    -- [ 'pp'      ] = { '',  desc='Paste as line below',        }
    -- [ '<C-h>'    ] = { '<C-w>h',  desc='Left Pane',                                                      }
    -- [ '<C-j>'    ] = { '<C-w>j',  desc='Down Pane',                                                      }
    -- [ '<C-k>'    ] = { '<C-w>k',  desc='Up Pane',                                                        }
    -- [ '<C-l>'    ] = { '<C-w>l',  desc='Right Pane',                                                     }
