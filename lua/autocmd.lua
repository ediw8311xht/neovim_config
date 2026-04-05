
local home  = vim.env.HOME
local va    = vim.api
local vfn   = vim.fn
local vauto = vim.api.nvim_create_autocmd
local vc    = vim.cmd

-- ConfigDir = vfn.stdpath("config")
LanguageSpecificDir = vfn.stdpath("config") .. "/language_specific"
TemplateDir = home .. "/.config/nvim/language_specific/templates"
MaxLinesCMP = 2000

------------------------------------------Buffer-Specific

local function set_buffer_autocommands(globcomms)
  for glob, cback in pairs(globcomms) do
    vauto({ "BufNewFile", "BufRead" }, {
      pattern = vfn.expand(glob),
      callback = cback
    })
  end
end

------------------------------------------------Templates

local function set_templates(exts)
  for ext, options in pairs(exts) do
    vauto({ "BufNewFile" }, {
      pattern = "*." .. ext,
      callback = function(args)
        if not PathValid(args.match) then
          error("path: '" .. args.match .. "' is invalid.")
        end
        local full_path = TemplateDir .. "/template." .. ext
        vc("keepalt 0read " .. full_path)
        vc("silent w")
        if options.chmod then
          vc("silent !chmod " .. options.chmod .. " %")
        end
      end
    })
  end
end

---------------------------------------Changing buffer hide cursor on inactive
va.nvim_create_augroup("cursorline_hide_inactive_buffer", { clear = true })
vauto({ "BufLeave", "WinLeave" }, {
  group = "cursorline_hide_inactive_buffer",
  callback = function() vim.opt_local.cursorline = false end
})

vauto({ "BufEnter", "WinEnter" }, {
  pattern = { "*" },
  group ="cursorline_hide_inactive_buffer",
  callback = function() vim.opt_local.cursorline = true end
})

---------------------------------------Large files disable cmp
vauto({ "BufEnter", "BufWinEnter" }, {
  callback = function(args)
    if va.nvim_buf_line_count(args.buf) > MaxLinesCMP then
      vim.treesitter.stop()
      require('cmp').setup.buffer( { enabled = false } )
    end
  end
})

---------------------------------------Check-File-Updates

vauto({ "FocusGained", "CursorHold", "CursorHoldI" }, {
  pattern = { "*" },
  callback = function() vc("silent! checktime") end
})

------------------------------------------------VimLeave

vauto({ "VimLeave" }, {
  pattern = "*",
  callback = function() ClipBoardExit() end
})

------------------------------------------------TermOpen
vauto({ "TermOpen" }, {
  pattern = "*",
  callback = function() vc("setlocal statusline=%{b:term_title}") end
})

-------------------------------------FileType_Formatting
vauto({ "FileType" }, {
  pattern = "*",
  callback = function() vc("setlocal formatoptions-=c formatoptions-=r formatoptions-=o") end
})
vauto({"FileType"}, {
  pattern = "help",
  command = "wincmd L",
})

vauto({ "TextYankPost" }, {
  pattern = "*",
  callback = function()
    vim.hl.on_yank( { higroup="Visual", timeout=300 } )
    -- MapCommandsToReg(vim.v.event)
  end
})

---------------------------------------ExtensionSpecific

local globcomms = {
  [ "*.page"                                 ] = function() vc( "source " .. LanguageSpecificDir .. "/gitit.vim"            ) end,
  [ "~/.bashrc"                              ] = function() vc( "source " .. LanguageSpecificDir .. "/bashrc.vim"           ) end,
  [ "~/.config/joplin-desktop/userstyle.css" ] = function() vc( "source " .. LanguageSpecificDir .. "/joplin_userstyle.vim" ) end,
  [ "~/TEST/QUICK/*.cpp"                     ] = function() vc( "source " .. LanguageSpecificDir .. "/quick_cpp.vim"        ) end,
}
local exts = {
  ["lisp"]   = { chmod = "600" },
  ["sh"]     = { chmod = "700" },
  ["py"]     = { chmod = "700" },
  ["kalker"] = { chmod = "700" },
  ["exs"]    = { chmod = "700" },
  ["tex"]    = { chmod = "700" },
  ["ex"]     = { chmod = "700" },
  ["html"]   = { chmod = "700" },
  ["cpp"]    = { chmod = "700" },
  ["hs"]     = { chmod = "700" },
  ["page"]   = { },
  ["md"]     = { },
}

set_templates(exts)
set_buffer_autocommands(globcomms)

-- {{{
----------------------------------------------YankedText
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
-- va.nvim_create_augroup("highlight_symbol_treesitter", { clear = true })
--
-- function ToggleLspDocumentHighlight()
--   if vfn.exists("highlight_symbol_treesitter") then
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

