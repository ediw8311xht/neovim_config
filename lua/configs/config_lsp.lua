local lsp_status = require("lsp-status")
local lsp_config = vim.lsp.config
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lsp saga
require("lspsaga").setup({
  lightbulb = {
    sign = false,
  },
})

vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
})

lsp_config("jsonls", { capabilities = cmp_capabilities })
lsp_config("ts_ls", { capabilities = cmp_capabilities })
lsp_config("vimls", { capabilities = cmp_capabilities })
lsp_config("eslint", {
  capabilities = cmp_capabilities,
  filetypes = { "css", "html" },
})

lsp_config("html", {
  capabilities = cmp_capabilities,
})

lsp_config("cssls", {
  capabilities = cmp_capabilities,
  settings = {
    css = {
      lint = {
        emptyRules = "ignore",
      },
    },
  },
})
lsp_config("pyright", {
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
      },
    },
  },
})

lsp_config("tailwindcss", {
  -- filetype = {},{{{
  -- filetypes = { "heex", "eex"},}}}
  filetypes = { "css" },
  capabilities = cmp_capabilities,
  -- init_options = {{{{
  --   userLanguages = {
  --     elixir = "html-eex",
  --     eelixir = "html-eex",
  --     heex = "html-eex"
  --   }
  -- }}}}
})

lsp_config("lua_ls", {
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
        disable = { "unused-label" },
        globals = { "vim" },
        type = {
          checkTableIndex = true,
          paramTypeMismatch = true,
        },
      },
    },
  },
})

lsp_config("bashls", {
  on_attach = lsp_status.on_attach,
  capabilities = cmp_capabilities,
  filetypes = { "bash" },
  settings = {
    bashIde = {
      shellcheckArguments = Printf("--rcfile %s", FS.joinpath(vim.env.HOME, ".config/", "shellcheckrc")),
    },
  },
})

lsp_config("clangd", {
  capabilities = cmp_capabilities,
  cmd = { "clangd", "--log=verbose" },
  filetypes = { "c", "cpp" },
  init_options = {
    fallbackFlags = {
      "--std=gnu++23",
      -- '-DMAGICKCORE_HDRI_ENABLE=1',
    },
  },
})

lsp_config("hls", {
  capabilities = cmp_capabilities,
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filestypes = { "haskell", "lhaskell" },
  single_file_support = true,
})

-- local configs = require("lspconfig.configs")
-- if not configs.sextant then
--   local util = require("lspconfig.util")
--   configs.sextant = {
--     default_config = {
--       cmd = { FS.joinpath(HOME, ".local/bin/", "sextant") },
--       filetypes = { "lisp" },
--       root_dir = util.root_pattern(".git", "*.asd", "*.asdf") or util.path.dirname,
--       settings = {},
--     },
--   }
-- end
-- require("lspconfig").sextant.setup({
--   capabilities = cmp_capabilities,
-- })

for _, v in ipairs(vim.g.lsp_lang_servers) do
  vim.lsp.enable(v)
end

-- local actions_preview  = require("actions-preview")
-- actions_preview.setup({})
