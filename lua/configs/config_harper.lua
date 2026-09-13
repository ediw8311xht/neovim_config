
vim.lsp.config("harper_ls", {
  -- filetypes = { "markdown", "text", "tex", "typst", "doc" },
  filetypes = { "doc" },
  settings = {
    ["harper-ls"] = {
      userDictPath = vim.g.personal_dictionary,
      workspaceDictPath = "",
      fileDictPath = "",
      linters = {
        SpellCheck = true,
        SpelledNumbers = false,
        AnA = true,
        SentenceCapitalization = true,
        UnclosedQuotes = true,
        WrongApostrophe = false,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
        CorrectNumberSuffix = true,
      },
      codeActions = {
        ForceStable = false,
      },
      markdown = {
        IgnoreLinkTitle = false,
      },
      diagnosticSeverity = "hint",
      isolateEnglish = false,
      dialect = "American",
      maxFileLength = 120000,
      ignoredLintsPath = "",
      excludePatterns = {},
    },
  },
})
