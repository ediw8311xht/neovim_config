
"<==============================================================================>
"<==------------------======================================------------------==>
"<==-----    ||||-----======================================-----    ||||-----==>
"<==-----    ||||-----==__________________________________==-----    ||||-----==>
"<==-    ||||||||||||-==                                  ==-    ||||||||||||-==>
"<==-    ||||||||||||-== Nvim Config - Maximilian Ballard ==-    ||||||||||||-==>
"<==-----    ||||-----==__________________________________==-----    ||||-----==>
"<==-----    ||||-----==                                  ==-----    ||||-----==>
"<==-----    ||||-----======================================-----    ||||-----==>
"<==-----    ||||-----======================================-----    ||||-----==>
"<==------------------======================================------------------==>
"<==============================================================================>
"<==============================================================================>
fu! SourceIf(file)
  let l:file = expand(a:file)
  if file_readable(l:file) 
    execute 'source ' .. l:file
  else
    echo "File not found " .. l:file
  endif
endfu

"call before so plugins/settings don't mess up things
lua require("autocmd")
lua require("variables")
lua require("my_highlight")

let vim_files = [ "settings", "functions", "slimv_settings", "conjure_settings", "vimtex_settings", "plugins" ]
let g:config_dir = expand("$XDG_CONFIG_HOME/nvim/vim")
for i in vim_files
  call SourceIf(printf("%s/%s.vim", g:config_dir, i))
endfor

lua require('base')

colorscheme pop-punk
lua CorrectColors()

