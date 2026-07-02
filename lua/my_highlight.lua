
-- # Highlighting that runs on starting vim and with CorrectColors.
vim.g.my_highlight = {
  [""] = {
    Keyword         = { gui = "NONE",                                          },
    -- Function        = { gui = "bold" },
    -- Function        = { gui = "bold", guibg="#00dd00", guifg="black" },
    CmpBorder       = { gui = "NONE",        guibg = "NONE",    guifg = "#009999", },
    ColorColumn     = { gui = "underdotted", guibg = "#222222", guifg = "#999999", },
    Comment         = { gui = "italic",      guibg = "NONE",    guifg = "#0077ff", },
    ExtraWhiteSpace = { gui = "NONE",        guibg = "#0099ff", guifg = "NONE",    },
    FoldColumn      = { gui = "NONE",        guibg = "NONE",    guifg = "#00ff00", },
    Folded          = { gui = "NONE",        guibg = "#222222", guifg = "#999999", },
    IncSearch       = { gui = "NONE",        guibg = "#ff0000", guifg = "black", },
    LineNr          = { gui = "NONE",        guibg = "NONE",    guifg = "#999999", },
    LineNrAbove     = { gui = "NONE",        guibg = "NONE",    guifg = "#990099", },
    MatchParen      = { gui = "NONE",        guibg = "#aaaaaa", guifg = "black", },
    Search          = { gui = "NONE",        guibg = "#ff00ff", guifg = "black", },
    SignColumn      = { gui = "NONE",        guibg = "NONE",    guifg = "NONE",    },
    TabLine         = { gui = "NONE",        guibg = "NONE",    guifg = "#999999", },
    TabLineSel      = { gui = "NONE",        guibg = "NONE",    guifg = "#00ff00", },
    TermCursor      = { gui = "NONE",        guibg = "NONE",    guifg = "#00aa00", },
    WinSeparator    = { gui = "NONE",        guibg = "NONE",    guifg = "#888888", },
    lCursor         = { gui = "NONE",        guibg = "NONE",    guifg = "NONE",    },
    ModeMsg         = { gui = "NONE",        guibg = "#009900", guifg = "black", cterm = "NONE",    },
    SpellBad        = { gui = "undercurl",   guibg = "NONE",    guifg = "#aaaaaa", guisp = "#ff0000", },
    -- Tree Sitter --
    TSCurrentScope  = { gui = "NONE", guibg = "#090909" },
    -- Custom ---
    -- LuaDocLine = { gui = "NONE", guibg = "#FF0000", guifg="#0099FF" },
  },
  My = {
    TextYank = { gui="bold", guibg="#FFFF00", guifg="#000000" },
  },

  man = {
    Bold           = { gui = "underline", guisp="#FFAA00" },
    Italic         = { gui = "italic",    guibg = "black",   guifg = "#999999" },
    SectionHeading = { gui="none", guifg="#44FF44" },
  },
  Window = {
    Active   = { guibg = "NONE" },
    Inactive = { gui = "NONE", guibg = "#090909" },
  },
  StatusLine = {
    [""]          = { gui = "BOLD,reverse",  guibg = "NONE", guifg = "#555555", },
    NC        = { gui = "NONE",  guibg = "NONE",    guifg = "#999999", },
    _Session  = { gui = "NONE",  guibg = "NONE",    guifg = "#ff9900", },
    _Lsp      = { gui = "NONE",  guibg = "NONE",    guifg = "#444444", },
    _File     = { gui = "NONE",  guibg = "NONE",    guifg = "#009999", },
    _Git      = { gui = "NONE",  guibg = "NONE",    guifg = "#009900", },

    _FullFile = { gui = "NONE",  guibg = "NONE",    guifg = "#999999", },
  },
  MarkSign = {
    NumHL      = { gui = "NONE",      guibg = "NONE",    guifg = "NONE", },
    VirtTextHL = { gui = "NONE",      guibg = "NONE",    guifg = "#00ff00", },
  },
  Floatterm = {
    [""]       = { guibg = "black", },
    Border     = { guibg = "black", guifg = "black", },
  },
  CursorLine = {
    [""]     = { gui = "underline", guisp = "#444444", guibg = "NONE", guifg = "NONE",    },
    Nr   = { gui = "NONE", guibg = "#111111", guifg = "#ff9900", },
    Sign = { gui = "NONE", guibg = "black", guifg = "black", },
  },
  Diagnostic = {
    Error           = { guifg = "black",   guibg = "#990000", },
    Hint            = { guifg = "black",   guibg = "#888888", },
    Info            = { guifg = "black",   guibg = "#aaaaaa", },
    Warn            = { guifg = "black",   guibg = "#aa8500", },
    UnderlineWarn   = { gui = "underdouble", guisp = "#999999", },
    UnderlineError  = { gui = "underdouble", guisp = "#ff0000", },
  },
  LspReference = {
    Text =  { gui = "reverse" }, -- , 'guibg=#009999' },
    Read =  { gui = "reverse" }, -- , 'guibg=#009999' },
    Target =  { gui = "reverse" }, -- , 'guibg=#009999' },
  },
  GitSigns = {
    Add = { guifg = "#00dd00", },
  },
  WhichKey = {
    Title      = { guibg = "#010101" ,   guifg = "#774400" ,           },
    [""]       = { guibg = "#010101" ,   guifg = "#229922" ,           },
    Normal     = { guibg = "#010101" ,   guifg = "#119911" ,           },
    Float      = { guibg = "#010101" ,                                 },
    Border     = { guibg = "NONE"    ,   guifg = "#444444" ,           },
    Group      = { guibg = "#777777" ,   guifg = "black" ,           },
    Separator  = { guibg = "black" ,   guifg = "#0099ff" ,           },
    Desc       = { guibg = "black" ,   guifg = "#aaaaaa" ,           },
    -- ["Value"]      = { gui = "italic", guibg = "NONE", guifg = "#777777", },
  },
  -- markup / markdown
  ["@comment."] = {
    ["documentation."] = {
      lua = { gui="reverse,bold" }
    }
  },
  ["@markup."] = {
    ["heading."] = {
      ["1.markdown"] = { gui = "bold", guibg = "black", guifg = "#00ffff", guisp = "black", },
      ["2.markdown"] = { gui = "bold", guibg = "black", guifg = "#00dddd", },
      ["3.markdown"] = { gui = "bold", guibg = "black", guifg = "#00aaaa", },
      ["4.markdown"] = { gui = "bold", guibg = "black", guifg = "#009999", },
      ["5.markdown"] = { gui = "bold", guibg = "black", guifg = "#009900", },
      ["6.markdown"] = { gui = "bold", guibg = "black", guifg = "#004400", },
    },
    link = {
      ["label.markdown_inline"] = { guibg = "#d070a0", guifg = "black", },
      ["url.markdown_inline"]   = { guibg = "#00aaaa", guifg = "black", },
    },
  },
  RainbowDelimiter = {
    _1 = { gui = "NONE", guifg = "#e6194b", }, -- Red
    _2 = { gui = "NONE", guifg = "#f58231", }, -- Orange
    _3 = { gui = "NONE", guifg = "#ffe119", }, -- Yellow
    _4 = { gui = "NONE", guifg = "#3cb44b", }, -- Green
    _5 = { gui = "NONE", guifg = "#4363d8", }, -- Blue
    _6 = { gui = "NONE", guifg = "#911eb4", }, -- Purple
    _7 = { gui = "NONE", guifg = "#f032e6", }, -- Magenta
  },
  -- ["@function"] = {  gui = "bold", guibg="#00dd00", guifg="black" },
  ["@function."] = {
    ["call"] = { gui = "NONE", guifg="#55bbbb" },
    ["commonlisp"] = { gui = "NONE", guibg = "#0c942b", guifg="black" },
    ["macro."] =  {
      commonlisp = { gui = "NONE", guifg="#eebb00" },
    },
  },
  [ "@string.special.symbol.commonlisp" ] = { gui = "none", guibg = "black", guifg="#ff00ff" },
  ["@variable."] = {
    ["parameter."] = {
      commonlisp = { gui = "underline", guisp = "#ffffff" },
      -- ["commonlisp"] = { gui = "NONE", guibg="#003300", guifg="#aaaaaa" },
    }
  },
}
-- ["EndOfBuffer"]     = { gui = "NONE",      guibg = "NONE",    guifg = "#333333",   },
-- ["Normal"]          = { gui = "NONE",      guibg = "NONE",    guifg = "#d0d0d0",   },
