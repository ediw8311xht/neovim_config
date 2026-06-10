
local home  = vim.env.HOME
local api   = vim.api
local fn    = vim.fn
local vauto = vim.api.nvim_create_autocmd
local cmd   = vim.cmd

-- ConfigDir = fn.stdpath("config")
LanguageSpecificDir = fn.stdpath("config") .. "/language_specific"
TemplateDir = home .. "/.config/nvim/language_specific/templates"
MaxLinesCMP = 2000

---for filename/filepath specific code when reading in buffer
local function set_buffer_autocommands(globcomms)
  for glob, cback in pairs(globcomms) do
    vauto({ "BufNewFile", "BufRead" }, {
      pattern = glob,
      callback = cback
    })
  end
end

---set templates to use when creating newfile with certain extension
local function set_templates(exts)
  for ext, options in pairs(exts) do
    vauto({ "BufNewFile" }, {
      pattern = "*." .. ext,
      callback = function(args)
        local new_file = args.match
        local template_file = TemplateDir .. "/template." .. ext
        ReadInFile(template_file, new_file, options)
      end
    })
  end
end

---disable cursor when leaving buffer/window
api.nvim_create_augroup("cursorline_hide_inactive_buffer", { clear = true })
vauto({ "BufLeave", "WinLeave" }, {
  group = "cursorline_hide_inactive_buffer",
  callback = function() vim.opt_local.cursorline = false end
})

---renable cursor when entering buffer/window
vauto({ "BufEnter", "WinEnter" }, {
  pattern = { "*" },
  group ="cursorline_hide_inactive_buffer",
  callback = function() vim.opt_local.cursorline = true end
})

---large files disable cmp
vauto({ "BufEnter", "BufWinEnter" }, {
  callback = function(args)
    if api.nvim_buf_line_count(args.buf) > MaxLinesCMP then
      vim.treesitter.stop()
      require('cmp').setup.buffer( { enabled = false } )
    end
  end
})

---check file updates
vauto({ "FocusGained", "CursorHold", "CursorHoldI" }, {
  pattern = { "*" },
  callback = function() cmd("silent! checktime") end
})

---preserve clipboard when exiting
vauto({ "VimLeave" }, {
  pattern = "*",
  callback = function() ClipBoardExit() end
})

---TermOpen
vauto({ "TermOpen" }, {
  pattern = "*",
  callback = function() cmd("setlocal statusline=%{b:term_title}") end
})

---FileType_Formatting
vauto({ "FileType" }, {
  pattern = "*",
  callback = function() cmd("setlocal formatoptions-=c formatoptions-=r formatoptions-=o") end
})
vauto({"FileType"}, {
  pattern = "help",
  command = "wincmd L",
})

---highlight text yank
vauto({ "TextYankPost" }, {
  pattern = "*",
  callback = function()
    vim.hl.on_yank( { higroup="Visual", timeout=300 } )
    -- MapCommandsToReg(vim.v.event)
  end
})

---for Makefiles
vauto({"BufNewFile", "Filetype" }, {
  pattern = "Makefile",
  callback = function(args)
    local template_file = TemplateDir .. "/template." .. "makefile"
    ReadInFile(template_file, args.match)
  end
})

---special settings based on filepath/filename 
local globcomms = {
  [ "*.page"                                 ] = function() dofile( LanguageSpecificDir .. "/gitit.lua" ) end,
  [ "~/.bashrc"                              ] = function() dofile( LanguageSpecificDir .. "/bashrc.lua" ) end,
  [ "~/.config/joplin-desktop/userstyle.css" ] = function() cmd.source( LanguageSpecificDir .. "/joplin_userstyle.vim" ) end,
  [ "~/TEST/QUICK/*.cpp"                     ] = function() cmd.source( LanguageSpecificDir .. "/quick_cpp.vim"        ) end,
  [ "*.asd"                                  ] = function() vim.bo.filetype="commonlisp" ; vim.bo.syntax="commonlisp" end,
}

---sets templates for extension. on new file with extension will read in template.
---options are passed to ReadInFile
local exts = {
  ["page"]     = { }, -- gitit
  ["md"]       = { },
  ["lisp"]     = { },
  ["nvim.lua"] = { }, -- this sets project settings for a directory (must trust if want to use)

  --obviously these files will have a shebang to allow executing
  ["sh"]     = { chmod = "700" },
  ["py"]     = { chmod = "700" },
  ["kalker"] = { chmod = "700" },
  ["exs"]    = { chmod = "700" },
  ["tex"]    = { chmod = "700" },
  ["ex"]     = { chmod = "700" },
  ["html"]   = { chmod = "700" },
  ["cpp"]    = { chmod = "700" },
  ["hs"]     = { chmod = "700" },
  ["tcl"]    = { chmod = "700" },
}

set_templates(exts)
set_buffer_autocommands(globcomms)

-- {{{
-- vauto({ "BufNewFile", "BufRead" }, {
--   pattern = "*.page",
--   callback = function()
--     cmd( "source " .. LanguageSpecificDir .. "/gitit.vim")
--   end,
-- })
---YankedText
-- -- For use with MapCommandsToReg
-- vim.g.reg_filter_map = {
--   [ 'normal' ] = { 'd', 'c', 'D', 'C' },
--   [ 'visual' ] = { 'd', 'c', 'D', 'C', 'p', 'P' },
-- }
-- function MapCommandsToReg(event)
--   if event['regname'] ~= "" then
--     return
--   end
--   local reg = vim.g.reg_filter_map['normal'][event['operator']]
--   -- if event['visual'] and
--   -- else
--   -- end
--   -- if Contains(vim.g.reg_filter_map, event["operator"]) then
--   --   print(vim.inspect(event))
--   -- end
-- end
-- -- Disable_CMP_For_Large_Files
--
-- api.nvim_create_augroup("highlight_symbol_treesitter", { clear = true })
--
-- function ToggleLspDocumentHighlight()
--   if fn.exists("highlight_symbol_treesitter") then
--     vim.g.enabled_lsp_document_highlight = false
--     vauto({ "CursorMoved" }, {
--       group = "highlight_symbol_treesitter",
--       callback = LspDocumentHighlight
--     })
--     vauto({"CursorMovedI" }, {
--       group = "highlight_symbol_treesitter",
--       callback = function()
--         vim.lsp.buf.clear_references()
--       end
--     })
--   end
-- end
-- ToggleLspDocumentHighlight()
-- }}}

