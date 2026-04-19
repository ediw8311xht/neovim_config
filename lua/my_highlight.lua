
-- # Highlighting that runs on starting vim and with CorrectColors.
vim.g.my_highlight = {
  [""] = {
    Keyword         = { gui = "NONE",                                          },
    Function        = { gui = "NONE",                                          },
    CmpBorder       = { gui = "NONE",        guibg = "NONE",    guifg = "#009999", },
    ColorColumn     = { gui = "underdotted", guibg = "#222222", guifg = "#999999", },
    Comment         = { gui = "NONE",        guibg = "NONE",    guifg = "#0077FF", },
    ExtraWhiteSpace = { gui = "NONE",        guibg = "#0099FF", guifg = "NONE",    },
    FoldColumn      = { gui = "NONE",        guibg = "NONE",    guifg = "#00FF00", },
    Folded          = { gui = "NONE",        guibg = "#222222", guifg = "#999999", },
    IncSearch       = { gui = "NONE",        guibg = "#FF0000", guifg = "#000000", },
    LineNr          = { gui = "NONE",        guibg = "NONE",    guifg = "#999999", },
    LineNrAbove     = { gui = "NONE",        guibg = "NONE",    guifg = "#990099", },
    MatchParen      = { gui = "NONE",        guibg = "#AAAAAA", guifg = "#000000", },
    Search          = { gui = "NONE",        guibg = "#FF00FF", guifg = "#000000", },
    SignColumn      = { gui = "NONE",        guibg = "NONE",    guifg = "NONE",    },
    TabLine         = { gui = "NONE",        guibg = "NONE",    guifg = "#999999", },
    TabLineSel      = { gui = "NONE",        guibg = "NONE",    guifg = "#00FF00", },
    TermCursor      = { gui = "NONE",        guibg = "NONE",    guifg = "#00AA00", },
    WinSeparator    = { gui = "NONE",        guibg = "NONE",    guifg = "#888888", },
    lCursor         = { gui = "NONE",        guibg = "NONE",    guifg = "NONE",    },
    ModeMsg         = { gui = "NONE",        guibg = "#009900", guifg = "#000000", cterm = "NONE",    },
    SpellBad        = { gui = "undercurl",   guibg = "NONE",    guifg = "#AAAAAA", guisp = "#FF0000", },
    -- Tree Sitter --
    TSCurrentScope  = { gui = "NONE", guibg = "#090909" },
  },
  Window = {
    Active   = { guibg = "NONE" },
    Inactive = { gui = "NONE", guibg = "#090909" },
  },
  StatusLine = {
    [""]          = { gui = "BOLD,reverse",  guibg = "NONE", guifg = "#555555", },
    NC        = { gui = "NONE",  guibg = "NONE",    guifg = "#999999", },
    _Session  = { gui = "NONE",  guibg = "NONE",    guifg = "#FF9900", },
    _Lsp      = { gui = "NONE",  guibg = "NONE",    guifg = "#444444", },
    _File     = { gui = "NONE",  guibg = "NONE",    guifg = "#009999", },
    _Git      = { gui = "NONE",  guibg = "NONE",    guifg = "#009900", },

    _FullFile = { gui = "NONE",  guibg = "NONE",    guifg = "#999999", },
  },
  MarkSign = {
    NumHL      = { gui = "NONE",      guibg = "NONE",    guifg = "NONE", },
    VirtTextHL = { gui = "NONE",      guibg = "NONE",    guifg = "#00FF00", },
  },
  Floatterm = {
    [""]       = { guibg = "#000000", },
    Border     = { guibg = "#000000", guifg = "#000000", },
  },
  CursorLine = {
    [""]     = { gui = "underline", guisp = "#444444", guibg = "#000000", guifg = "NONE",    },
    Nr   = { gui = "NONE", guibg = "#111111", guifg = "#FF9900", },
    Sign = { gui = "NONE", guibg = "#000000", guifg = "#000000", },
  },
  Diagnostic = {
    Error           = { guifg = "#000000",   guibg = "#990000", },
    Hint            = { guifg = "#000000",   guibg = "#888888", },
    Info            = { guifg = "#000000",   guibg = "#AAAAAA", },
    Warn            = { guifg = "#000000",   guibg = "#AA8500", },
    UnderlineWarn   = { gui = "underdouble", guisp = "#999999", },
    UnderlineError  = { gui = "underdouble", guisp = "#FF0000", },
  },
  LspReference = {
    Text =  { gui = "reverse" }, -- , 'guibg=#009999' },
    Read =  { gui = "reverse" }, -- , 'guibg=#009999' },
    Target =  { gui = "reverse" }, -- , 'guibg=#009999' },
  },
  GitSigns = {
    Add = { guifg = "#00DD00", },
  },
  WhichKey = {
    Title      = { guibg = "#010101" ,   guifg = "#774400" ,           },
    [""]       = { guibg = "#010101" ,   guifg = "#229922" ,           },
    Normal     = { guibg = "#010101" ,   guifg = "#119911" ,           },
    Float      = { guibg = "#010101" ,                                 },
    Border     = { guibg = "NONE"    ,   guifg = "#444444" ,           },
    Group      = { guibg = "#777777" ,   guifg = "#000000" ,           },
    Separator  = { guibg = "#000000" ,   guifg = "#0099FF" ,           },
    Desc       = { guibg = "#000000" ,   guifg = "#AAAAAA" ,           },
    -- ["Value"]      = { gui = "italic", guibg = "NONE", guifg = "#777777", },
  },
  -- markup / markdown
  ["@markup."] = {
    ["heading."] = {
      ["1.markdown"] = { gui = "bold", guibg = "#000000", guifg = "#00FFFF", guisp = "#000000", },
      ["2.markdown"] = { gui = "bold", guibg = "#000000", guifg = "#00DDDD", },
      ["3.markdown"] = { gui = "bold", guibg = "#000000", guifg = "#00AAAA", },
      ["4.markdown"] = { gui = "bold", guibg = "#000000", guifg = "#009999", },
      ["5.markdown"] = { gui = "bold", guibg = "#000000", guifg = "#009900", },
      ["6.markdown"] = { gui = "bold", guibg = "#000000", guifg = "#004400", },
    },
    link = {
      ["label.markdown_inline"] = { guibg = "#D070A0", guifg = "#000000", },
      ["url.markdown_inline"]   = { guibg = "#00AAAA", guifg = "#000000", },
    },
  },
  RainbowDelimiter = {
    _1 = { gui = "NONE", guifg = "#E6194B", }, -- Red
    _2 = { gui = "NONE", guifg = "#F58231", }, -- Orange
    _3 = { gui = "NONE", guifg = "#FFE119", }, -- Yellow
    _4 = { gui = "NONE", guifg = "#3CB44B", }, -- Green
    _5 = { gui = "NONE", guifg = "#4363D8", }, -- Blue
    _6 = { gui = "NONE", guifg = "#911EB4", }, -- Purple
    _7 = { gui = "NONE", guifg = "#F032E6", }, -- Magenta
  }
}
-- ["EndOfBuffer"]     = { gui = "NONE",      guibg = "NONE",    guifg = "#333333",   },
-- ["Normal"]          = { gui = "NONE",      guibg = "NONE",    guifg = "#D0D0D0",   },
