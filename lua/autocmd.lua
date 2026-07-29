
---@diagnostic disable: deprecated
local home  = vim.env.HOME
local api   = vim.api
local fn    = vim.fn
local vauto = vim.api.nvim_create_autocmd
local cmd   = vim.cmd

-- ConfigDir = fn.stdpath("config")
LanguageSpecificDir = fn.stdpath("config") .. "/language_specific"
TemplateDir = home .. "/.config/nvim/language_specific/templates"
MaxLinesCMP = 2000

---special settings based on filepath/filename 
local special_settings = {
  [ "*.page"                                 ] = function() dofile( LanguageSpecificDir .. "/gitit.lua" ) end,
  [ "~/.bashrc"                              ] = function() dofile( LanguageSpecificDir .. "/bashrc.lua" ) end,
  [ "~/.config/joplin-desktop/userstyle.css" ] = function() cmd.source( LanguageSpecificDir .. "/joplin_userstyle.vim" ) end,
  [ "~/TEST/QUICK/*.cpp"                     ] = function() cmd.source( LanguageSpecificDir .. "/quick_cpp.vim"        ) end,
  [ "*.asd"                                  ] = function() vim.bo.filetype="commonlisp" ; vim.bo.syntax="commonlisp" end,
}

---sets templates for extension. on new file with extension will read in template.
---options are passed to ReadInFile
local template_extensions = {
  ["nvim.lua"] = nil, -- this sets project settings for a directory (must trust if want to use)
  Makefile     = { exact_match = true },
  html         = nil,
  lisp         = nil,
  md           = nil,
  page         = nil, -- gitit
  -- executable
  sh     = { chmod = "700" },
  py     = { chmod = "700" },
  kalker = { chmod = "700" },
  exs    = { chmod = "700" },
  ex     = { chmod = "700" },
  cpp    = { chmod = "700" },
  hs     = { chmod = "700" },
  tcl    = { chmod = "700" },
  tex    = { chmod = "700" }, -- maybe
}

api.nvim_create_augroup("cursorline_hide_inactive_buffer", { clear = true })
MyAutoCommands = {
  ---hide cursor for inactive window
  [ { "BufLeave", "WinLeave" } ] = { group = "cursorline_hide_inactive_buffer",
    callback = function() vim.opt_local.cursorline = false end
  },
  [ { "BufEnter", "WinEnter" } ] = { group ="cursorline_hide_inactive_buffer",
    callback = function() vim.opt_local.cursorline = true end
  },
  ---large files disable cmp
  [ { "BufEnter", "BufWinEnter" } ] = {
    callback = function(args)
      if api.nvim_buf_line_count(args.buf) > MaxLinesCMP then
        vim.treesitter.stop()
        require('cmp').setup.buffer( { enabled = false } )
      end
    end
  },
  ---check file updates
  [ { "FocusGained", "CursorHold", "CursorHoldI" } ] = { callback = function() cmd("silent! checktime") end },
  ---preserve clipboard when exiting
  [ { "VimLeave" } ] = { callback = function() ClipBoardExit() end },
  ---set status line to terminal title
  [ { "TermOpen" } ] = { callback = function() cmd("setlocal statusline=%{b:term_title}") end },
  ---filetype formatting
  [ { "FileType" } ] = { callback = function() cmd("setlocal formatoptions-=c formatoptions-=r formatoptions-=o") end },
  ---open help on right side
  [ { {"FileType"}, "help" } ] = { command = "wincmd L", },
  ---highlight text yank
  [ { "TextYankPost" } ] = { callback = function() vim.hl.on_yank( { higroup="MyTextYank", timeout=300 } ) end },
}

---for filename/filepath specific code when reading in buffer
local function set_buffer_autocommands(globs_commands)
  for glob, cback in pairs(globs_commands) do
    vauto({ "BufNewFile", "BufRead" }, {
      pattern = glob,
      callback = cback
    })
  end
end

---set templates to use when creating newfile with certain extension
local function set_templates(exts)
  for ext, opts in pairs(exts) do
    local options = opts or {}
    local ext_pattern = (options.exact_match and ext or ("*." .. ext))
    vauto({ "BufNewFile" }, {
      pattern = ext_pattern,
      callback = function(args)
        local new_file = args.match
        local template_file = TemplateDir .. "/template." .. ext
        ReadInFile(template_file, new_file, options)
      end
    })
  end
end

---handles setting bulk autocommands
local function handle_auto_commands(autocommands)
  for group_pattern, value in pairs(autocommands) do
    local group, pattern = unpack(group_pattern)
    if pattern then value["pattern"] = pattern end
    api.nvim_create_autocmd(group, value)
  end
end

handle_auto_commands(MyAutoCommands)
set_templates(template_extensions)
set_buffer_autocommands(special_settings)


-- {{{ commented out
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

