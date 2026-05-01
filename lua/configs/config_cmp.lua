local cmp = require("cmp")
local cmp_dict = require("cmp_dictionary")

cmp.setup({
  formatting = {
    -- https://github.com/xzbdmw/colorful-menu.nvim#use-it-in-nvim-cmp
    format = function(entry, vim_item)
      local highlights_info = require("colorful-menu").cmp_highlights(entry)

      -- highlight_info is nil means we are missing the ts parser, it's
      -- better to fallback to use default `vim_item.abbr`. What this plugin
      -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
      if highlights_info ~= nil then
        vim_item.abbr_hl_group = highlights_info.highlights
        vim_item.abbr = highlights_info.text
      end

      return vim_item
    end,
  },
  -- commented out for now
  performance = {
    -- filtering_context_budget = 100,
    -- confirm_resolve_timeout = 100,
    -- fetching_timeout = 100,
    -- debounce = 60,
    -- throttle = 1000,
    -- async_budget = 40,
    -- max_view_entries = 20,
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  window = {
    completion = {
      winhighlight = "FloatBorder:CmpBorder,Normal:NormalFloat",
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    },
    documentation = {
      winhighlight = "FloatBorder:CmpBorder,Normal:NormalFloat",
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
      min_width = 20,
      min_height = 30,
      max_width = nil,
      max_height = nil,
    },
    MaxLinesCMP,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-S-e>"] = cmp.mapping.close(),
    ["<C-S-y>"] = cmp.mapping.complete({
      config = { sources = { { name = "treesitter" } } },
    }),
    ["<C-S-p>"] = cmp.mapping.complete({
      config = { sources = { { name = "path" }, { name = "dotenv" } } },
    }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "nvim_lsp_signature_help" },
    -- { name = 'ctags' },
    -- { name = 'cmp-nvim-tags' },
  }, {
    { name = "buffer" },
    { name = "path", option = {
      indexing_interval = 80,
      indexing_batch_size = 110,
    } },
    { name = "dotenv" },
    --{ name = 'cmdline'},
  }),
})

cmp.setup.filetype({ "lisp", "commonlisp" }, {
  sources = {
    { name = "omni" },
    { name = "buffer" },
  },
  mapping = {
    ["C-S-y"] = cmp.mapping.complete({
      config = {
        sources = {
          { name = "omni" },
          { name = "treesitter" },
          { name = "buffer" },
        },
      },
    }),
  },
})
cmp.setup.filetype({ "tex" }, {
  sources = {
    { name = "vimtex" },
    { name = "latex_symbols" },
    -- { name = "dictionary" },
  },
})

cmp.setup.filetype({ "markdown", "text" }, {
  sources = {
    { name = "dictionary" },
  },
})

cmp.setup.filetype({ "lua" }, {
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
  },
})

cmp_dict.setup({
  paths = { "$XDG_DATA_HOME/dict/en_words" },
  exact_length = 2,
  first_case_insensitive = true,
  document = {
    enable = true,
    command = {
      vim.fs.joinpath(vim.g.my_scripts_dir, "definition_search.sh"),
      "${label}",
    },
  },
})
