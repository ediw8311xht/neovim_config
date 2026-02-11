
local home  = vim.env.HOME
local va    = vim.api
local vfn   = vim.fn
local vauto = vim.api.nvim_create_autocmd
local vc    = vim.cmd

-- ConfigDir = vfn.stdpath("config")
LanguageSpecificDir = vfn.stdpath("config") .. "/language_specific"
TemplateDir = home .. "/.config/nvim/language_specific/templates"
MaxLinesCMP = 2000



--[[ {{{

-- Disable_CMP_For_Large_Files
va.nvim_create_augroup("highlight_symbol_treesitter", { clear = true })

function ToggleLspDocumentHighlight()
  if vfn.exists("highlight_symbol_treesitter") then
    vim.g.enabled_lsp_document_highlight = false
    vauto({ "CursorMoved" }, {
      group = "highlight_symbol_treesitter",
      callback = LspDocumentHighlight
    })
    vauto({"CursorMovedI" }, {
      group = "highlight_symbol_treesitter",
      callback = function()
        vim.lsp.buf.clear_references()
      end
    })
  end
end
ToggleLspDocumentHighlight()

}}} --]]


va.nvim_create_augroup("cursorline_hide_inactive_buffer", { clear = true })

vauto({ "BufLeave", "WinLeave" }, {
  group = "cursorline_hide_inactive_buffer",
  callback = function()
    vim.opt_local.cursorline = false
  end
})

vauto({ "BufEnter", "WinEnter" }, {
  pattern = { "*" },
  group ="cursorline_hide_inactive_buffer",
  callback = function()
    vim.opt_local.cursorline = true
  end
})

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

------------------------------------------Buffer-Specific

local function bufnew_bufread(glob, comms)
  vauto({ "BufNewFile", "BufRead" }, {
    pattern = glob,
    callback = function() for _,com in ipairs(comms) do vc(com) end
  end
})
end

local function bufnr_add(globcomms)
  for glob,comms in pairs(globcomms) do
    bufnew_bufread(vfn.expand(glob), comms)
  end
end

------------------------------------------------Templates

local function template_add(glob, template_file, options)
  vauto({ "BufNewFile" }, {
    pattern = glob,
    callback = function()
      local full_path = TemplateDir .. template_file
      vc("keepalt 0read " .. full_path)
      vc("silent w")
      if options.chmod then
        vc("silent !chmod " .. options.chmod .. " %")
      end
    end
  })
end

local function template_add_e(exts)
  for ext, options in pairs(exts) do
    template_add("*." .. ext, "/template." .. ext, options)
  end
end

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

-- eventually will move this to settings.vim
vim.filetype.add({
  extension = {
    [ 'ex'             ] = 'elixir',
    [ 'exs'            ] = 'exliir',
    [ 'hs'             ] = 'haskell',
    [ 'kalker'         ] = 'kalker',
    [ 'lisp'           ] = 'lisp',
    [ 'page'           ] = 'markdown',
    [ 'schema'         ] = 'sql',
    [ 'scm'            ] = 'scheme',
    [ 'sh'             ] = 'bash',
    [ 'kitty-session'  ] = 'kitty-session',
    [ 'md'             ] = "markdown",
  },
  pattern = {
    [ '${HOME}/bashrc_files/.*'            ] = 'bash',
    [ '${XDG_CONFIG_HOME}/polybar/.*%.ini' ] = 'dosini',
    [ '${XDG_CONFIG_HOME}/i3/.*'           ] = 'i3',
    [ '${XDG_CONFIG_HOME}/zathura/.*'      ] = 'zathurarc',
    -- [ "~/.config/zathura/*"        ] = { "set syntax=zathurarc"  } ,
    -- [ .config/polybar/*/*.ini"  ] = { "setfiletype dosini"    } ,
  }
})


local globcomms = {
  ---- Syntax ----
  [ "~/.config/i3/*" ] = { "setfiletype i3"        } ,
  ---- Special ----
  [ "*.page"                                 ] = { "source " .. LanguageSpecificDir .. "/gitit.vim"            },
  [ "~/.bashrc"                              ] = { "source " .. LanguageSpecificDir .. "/bashrc.vim"           },
  [ "~/.config/joplin-desktop/userstyle.css" ] = { "source " .. LanguageSpecificDir .. "/joplin_userstyle.vim" },
  [ "~/TEST/QUICK/*.cpp"                     ] = { "source " .. LanguageSpecificDir .. "/quick_cpp.vim"        },
}

local exts = {
  ["sh"]     = { chmod = "700" },
  ["py"]     = { chmod = "700" },
  ["kalker"] = { chmod = "700" },
  ["exs"]    = { chmod = "700" },
  ["tex"]    = { chmod = "700" },
  ["ex"]     = { chmod = "700" },
  ["html"]   = { chmod = "700" },
  ["cpp"]    = { chmod = "700" },
  ["lisp"]   = { chmod = "700" },
  ["hs"]     = { chmod = "700" },
  ["page"]   = { },
  ["md"]     = { },
}

template_add_e(exts)
bufnr_add(globcomms)

----------------------------------------------YankedText {{{
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
    -- end }}}
