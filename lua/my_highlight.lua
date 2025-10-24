-- hi 
-- hi InactiveWindow ctermbg=233 guibg=#3a3a3a
vim.g.my_highlight = {
  [""] = {
    -- ["Comment"]  = { "ctermbg=blue",  "ctermfg=black", "gui=NONE",    "guibg=NONE",      "guifg=#1144AA", },
    ["ModeMsg"]  = { "cterm=NONE",    "gui=NONE",      "guibg=#009900", "guifg=#000000", },
    ["SpellBad"] = { "gui=undercurl", "guibg=NONE",    "guifg=#AAAAAA", "guisp=#FF0000", },
    ["clear"]    = { "@lsp.mod",},
    ["ColorColumn"]     = { "gui=underdotted",      "guibg=#222222", "guifg=#999999",      },
    -- ["EndOfBuffer"]     = { "gui=NONE",      "guibg=NONE",    "guifg=#333333",   },
    ["ExtraWhiteSpace"] = { "gui=NONE",      "guibg=#0099FF", "guifg=NONE",      },
    ["FoldColumn"]      = { "gui=NONE",      "guibg=NONE",    "guifg=#00FF00",   },
    ["Folded"]          = { "gui=NONE",      "guibg=#222222", "guifg=#999999",   },
    ["HLspStatus"]      = { "gui=NONE",      "guibg=NONE",    "guifg=#00FF00",   },
    ["HStatusFullFile"] = { "gui=NONE",      "guibg=NONE",    "guifg=#999999",   },
    ["IncSearch"]       = { "gui=NONE",      "guibg=#FF0000", "guifg=#000000",   },
    ["LineNrAbove"]     = { "gui=NONE",      "guibg=NONE",    "guifg=#990099",   },
    ["LineNr"]          = { "gui=NONE",      "guibg=NONE",    "guifg=#999999",   },
    ["MatchParen"]      = { "gui=NONE",      "guibg=#AAAAAA", "guifg=#000000",   },
    -- ["Normal"]          = { "gui=NONE",      "guibg=NONE",    "guifg=#D0D0D0",   },
    ["Search"]          = { "gui=NONE",      "guibg=#FF00FF", "guifg=#000000",   },
    ["SignColumn"]      = { "gui=NONE",      "guibg=NONE",    "guifg=NONE",      },
    ["TabLine"]         = { "gui=NONE",      "guibg=NONE",    "guifg=#999999",   },
    ["TabLineSel"]      = { "gui=NONE",      "guibg=NONE",    "guifg=#00FF00",   },
    ["TermCursor"]      = { "gui=NONE",      "guibg=NONE",    "guifg=#00AA00",   },
    ["WinSeparator"]    = { "gui=NONE",      "guibg=NONE",    "guifg=#FFFF00",   },
    ["lCursor"]         = { "gui=NONE",      "guibg=NONE",    "guifg=NONE",      },
    ["DiagnosticUnderlineWarn"] = { "gui=underdouble", "guisp=#999999" },
    ["DiagnosticUnderlineError"] = {  "gui=underdouble", "guisp=#FF0000" },
    ["Function"]        = { "gui=NONE" },
    ["Keyword"]         = { "gui=NONE" },
    -- Tree Sitter --
    ["TSCurrentScope"]  = { "gui=NONE", "guibg=#090909" },
  },
  -- For use with set
  ["Window"] = {
    ["Active"]   = { "guibg=NONE" },
    ["Inactive"] = { "guibg=#1a1a1a" },
  },
  ["StatusLine"] = {
    [""]         = { "gui=NONE",      "guibg=NONE",    "guifg=#229922", },
    ["NC"]       = { "gui=NONE",      "guibg=NONE",    "guifg=#999999", },
  },
  ["MarkSign"] = {
    ["NumHL"]      = { "gui=NONE",      "guibg=NONE",    "guifg=NONE", },
    ["VirtTextHL"] = { "gui=NONE",      "guibg=NONE",    "guifg=#00FF00", },
  },

  ["Floatterm"] = {
    [""]       = { "guibg=#000000", },
    ["Border"] = { "guibg=#000000", "guifg=#000000", },
  },

  ["CursorLine"] = {
    [""]     = { "gui=bold,underline", "guisp=#444444", "guibg=#000000", "guifg=NONE",    },
    ["Nr"]   = { "gui=NONE", "guibg=#111111", "guifg=#FF9900", },
    ["Sign"] = { "gui=NONE", "guibg=#000000", "guifg=#000000", },
  },

  ["Diagnostic"] = {
    ["Error"]    = { "guifg=#000000", "guibg=#990000", },
    ["Hint"]     = { "guifg=#000000", "guibg=#888888", },
    ["Info"]     = { "guifg=#000000", "guibg=#AAAAAA", },
    ["Warn"]     = { "guifg=#000000", "guibg=#AA8500", },
  },

  ["GitSigns"] = {
    ["Add"] = { "guifg=#00DD00", },
  },

  ["WhichKey"] = {
    [""]           = { "guibg=#010101", "guifg=#22FF22",            },
    ["Normal"]     = { "guibg=#010101", "guifg=#00FF00",            },
    ["Float"]      = { "guibg=#010101",                             },
    ["Border"]     = { "guibg=NONE", "guifg=#444444",               },
    ["Group"]      = { "guibg=NONE", "guifg=#999999",               },
    -- ["Separator"]  = { "guibg=NONE",                                },
    -- ["Desc"]       = { "guibg=NONE",                                },
    -- ["Value"]      = { "gui=italic", "guibg=NONE", "guifg=#777777", },
  },

  ["@markup."] = {
    ["heading."] = {
      ["1.markdown"] = { "gui=bold", "guibg=#000000", "guifg=#00FFFF", "guisp=#000000", },
      ["2.markdown"] = { "gui=bold", "guibg=#000000", "guifg=#00DDDD", },
      ["3.markdown"] = { "gui=bold", "guibg=#000000", "guifg=#00AAAA", },
      ["4.markdown"] = { "gui=bold", "guibg=#000000", "guifg=#009999", },
      ["5.markdown"] = { "gui=bold", "guibg=#000000", "guifg=#009900", },
      ["6.markdown"] = { "gui=bold", "guibg=#000000", "guifg=#004400", },
    },
  },
  ["RainbowDelimiter"] = {
    [ '1' ] = { "gui=ITALIC", "guifg=#E6194B", }, -- Red
    [ '2' ] = { "gui=ITALIC", "guifg=#F58231", }, -- Orange
    [ '3' ] = { "gui=ITALIC", "guifg=#FFE119", }, -- Yellow
    [ '4' ] = { "gui=ITALIC", "guifg=#3CB44B", }, -- Green
    [ '5' ] = { "gui=ITALIC", "guifg=#4363D8", }, -- Blue
    [ '6' ] = { "gui=ITALIC", "guifg=#911EB4", }, -- Purple
    [ '7' ] = { "gui=ITALIC", "guifg=#F032E6", }, -- Magenta
  }
}
