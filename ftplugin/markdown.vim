
setlocal tabstop=2 shiftwidth=2 softtabstop=4 expandtab
let g:loaded_mark_preview=0

fu! MakeSafe(f)
  return substitute(a:f, '[/.]', '\\%', 'g')
endfu

fu! WritePreview()
  let l:file = expand("%:p")
  let l:temp_file = '/tmp/' .. MakeSafe(file) .. ".html"
  echo l:temp_file
  "execute "!pandoc -f markdown -t html % > " .. l:temp_file
  execute printf("!%s/pandoc_format.sh --to html <'%s' > %s", g:dir_scripts, l:file, l:temp_file)
  return l:temp_file
endfu

fu! PreviewMarkdown(flag = "")
  let l:temp_file = WritePreview()

  if a:flag == "q"
    execute ":silent !qutebrowser " .. l:temp_file
  elseif a:flag == "b"
    execute ":silent !${BROWSER} " .. l:temp_file
  elseif g:loaded_mark_preview == 0
    execute ":vertical:T lynx " .. l:temp_file
    let g:loaded_mark_preview = 1
  else
    execute ":vertical:Topen"
    execute ":T \<c-r>"
  endif
endfu

"colorscheme cyberpunk-neon
"call CorrectColors()
"set formatexpr=1
"set textwidth=80
"set wrap
"set spell
let @s='<u>'
let @e='</u>'

lua <<EOF
MARKDOWN_KEYMAP = {
  i = {
    [ '<C-S-U>' ] = { false, "add underline",           '<C-r>s<C-r>e<esc>F<i' },
    [ '<C-l>'   ] = { false, "add $$ (latex)",          '$$<left>' },
  },
  n = {
    [ '<C-l>'   ] = { false, "add $$ (latex)",          'i$$<left><esc>' },
  },
  v = {
    [ '<C-l>'   ] = { false, "surround with $ (latex)", 'c$<C-r>"$<esc>' },
    x = { false, "Format", ":!" .. vim.g.formatdef_pandoc_format .. "<CR>" }
  },
}

MARKDOWN_KEYMAP_LEADER = {
  n = {
    cT = { false, "Add table line",     'a| --- <ESC>a|<ESC>' },
    x  = { false, "Format",             'Autoformat', cmd=true },
    -- oo = { false, "Preview Markdown",   ':silent call PreviewMarkdown()<esc>' },
    -- oq = { false, "q Preview Markdown", ':silent call PreviewMarkdown("q")<esc>' },
    -- ob = { false, "b Preview Markdown", ':silent call PreviewMarkdown("b")<esc>' },
    om = { false, "n Preview Markdown", 'MarkdownPreview', cmd=true},
    HB = { false, "print buffer local mappings", "lua= 'leader',MARKDOWN_KEYMAP_LEADER, 'regular',MARKDOWN_KEYMAP", cmd=true },
  },
  v = {
    vu = { false, "Underline", ':s/\\%V\\c.*\\%V./<u>\\0<\\/u>/<ESC>:nohl<ESC>' },
  }
}

KeyMapSetter(MARKDOWN_KEYMAP, "", true, true)
KeyMapSetter(MARKDOWN_KEYMAP_LEADER, "<leader>", true, true)
EOF

