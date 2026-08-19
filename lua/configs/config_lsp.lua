local lsp_status        = require('lsp-status')
local lspconfig         = vim.lsp.config
local cmp_capabilities  = require('cmp_nvim_lsp').default_capabilities()
local actions_preview   = require('actions-preview')
local lspsaga           = require('lspsaga')

vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  }
})

actions_preview.setup({})
lspsaga.setup({})

lspconfig('jsonls',  { capabilities = cmp_capabilities })
lspconfig('ts_ls',   { capabilities = cmp_capabilities })
lspconfig('vimls',   { capabilities = cmp_capabilities })
lspconfig('eslint',  { } )

lspconfig('html', {
  capabilities = cmp_capabilities
})

lspconfig('cssls', {
  capabilities = cmp_capabilities,
  settings = {
    css = {
      lint = {
        emptyRules = "ignore",
      },
    },
  },
})
lspconfig('pyright', {
  on_attach = lsp_status.on_attach,
  capabilities = cmp_capabilities,
  settings = {
    pyright = {
      autoImportCompletion = true,
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "off",
      }
    }
  }
})

lspconfig('tailwindcss', {
  -- filetype = {},
  -- filetypes = { "heex", "eex"},
  capabilities = cmp_capabilities,
  -- init_options = {
  --   userLanguages = {
  --     elixir = "html-eex",
  --     eelixir = "html-eex",
  --     heex = "html-eex"
  --   }
  -- }
})

lspconfig('lua_ls', {
  capabilities = cmp_capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = { vim.env.VIMRUNTIME },
        checkThirdParty = false,
      },
      diagnostics = {
        enable = true,
        disable = {},
        globals = { 'vim' },
        type = {
          checkTableIndex = true,
          paramTypeMismatch = true,
        },
      }
    }
  }
})

lspconfig('bashls', {
  on_attach = lsp_status.on_attach,
  capabilities = cmp_capabilities,
  filetypes = { "bash" },
  settings = {
    bashIde = {
      shellcheckArguments = Printf("--rcfile %s", vim.fs.joinpath(vim.env.HOME, ".config/", "shellcheckrc"))
    }
  }
})

lspconfig('clangd', {
  capabilities = cmp_capabilities,
  cmd = { "clangd", "--log=verbose" },
  filetypes = {'c', 'cpp'},
  init_options = {
    fallbackFlags = {
      '--std=gnu++23',
      -- '-DMAGICKCORE_HDRI_ENABLE=1',
    }
  }
})

lspconfig('hls', {
  capabilities = cmp_capabilities,
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filestypes = { "haskell", "lhaskell" },
  single_file_support = true,
})

-- harper {{{
lspconfig("harper_ls", {
  filetypes = { 'markdown', 'text', 'tex', 'typst' },
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
        CorrectNumberSuffix = true
      },
      codeActions = {
        ForceStable = false
      },
      markdown = {
        IgnoreLinkTitle = false
      },
      diagnosticSeverity = "hint",
      isolateEnglish = false,
      dialect = "American",
      maxFileLength = 120000,
      ignoredLintsPath = "",
      excludePatterns = {}
    }
  }
}) -- }}}

for _,v in ipairs(vim.g.lsp_lang_servers) do
  vim.lsp.enable(v)
end

