(local {: autoload} (require :nfnl.module))

(local which_key (require :which-key))

(local mod {})

(fn mod.register_binding [{: mode : key}
                          {: typet
                           : value
                           : desc
                           : remap
                           : expr
                           : with_which_key
                           : with_leader
                           }]
  (local with_leader (= with_leader true))
  (local remap  (= remap true))
  (var typet (or typet :normal))
  (var key (or (and with_leader (.. "," key)) key))
  (var value value)
  (case (string.lower typet)
    :cmd          (set value (vim.fn.printf "<CMD>%s<CR>"   value))
    :vim_command  (set value (vim.fn.printf ":%s<CR>"       value))
    :vim_function (set value (vim.fn.printf ":call %s<CR>"  value))
    :echo         (set value (vim.fn.printf ":echo %s<CR>"  value))
    :lua          (set value (vim.fn.printf ":lua %s<CR>"   value))
    :normal nil)
  (vim.keymap.set mode key value {: desc : remap : expr})
  (when (and which_key with_which_key)
    (which_key.add {1 key : desc : mode})))

(fn mod.register_binding_multiple [base_table]
  (each [mode sub_table (pairs base_table)]
    (each [key mapping (pairs sub_table)]
      (mod.register_binding {: key : mode} mapping))))



(global REGULAR_MAPPINGS {; {{{
"" {
  :+          { :desc "End of line"                 :value :g_
                :remap true }
  ","         { :desc :<leader>                     :value :<leader>
                :remap true }
  ",;"        { :desc ""                            :value ","                                         }
  :x          { :desc ""                            :value "\"xx"                                      }
}
:c {
  :<C-S-k>    { :desc ""                            :value :<C-c>D<C-c>                                }
}
:i {
  :<C-S-b>    { :desc "backward whole word"         :value :<C-o>B                                     }
  :<C-S-f>    { :desc "forward whole word"          :value :<C-o>W                                     }
  :<C-S-g>    { :desc "new undo point"              :value :<C-g>u                                     }
  :<C-S-k>    { :desc "delete to end of line"       :value :<C-g>u<C-o>D                               }
  :<C-S-t>    { :desc "remove indent"               :value :<C-d>                                      }
  :<C-S-u>a   { :desc "new undo point"              :value :<C-g>u                                     }
  :<C-S-u>r   { :desc :redo                         :value :<C-o><C-r>                                 }
  :<C-S-u>u   { :desc :undo                         :value :<C-o>u                                     }
  :<C-u>      { :desc "del entered chars b4 curs"   :value :<C-g>u<C-u>                                }
  :jk         { :desc "exit Insert[m ]"             :value :<ESC>                                      }
}
:n {
  "`"         { :desc :fold                         :value "@=(foldlevel('.')?'za':\"<Space>\")<CR>"   }
  "{"         { :desc "prev function start"         :value :GotoPrevFunctionStart   :typet :vim_command }
  "}"         { :desc "next function start"         :value :GotoNextFunctionStart   :typet :vim_command }
  :/          { :desc "search vmagic"               :value "/\\v\\c"                                   }
  :<C-S-E>    { :desc "end of previous word"        :value :ge                                         }
  :<C-S-H>    { :desc "left pane"                   :value :<C-w>h                                     }
  :<C-S-J>    { :desc "down pane"                   :value :<C-w>j                                     }
  :<C-S-K>    { :desc "up Pane"                     :value :<C-w>k                                     }
  :<C-S-L>    { :desc "right pane"                  :value :<C-w>l                                     }
  :<C-S-Tab>  { :desc "previous tab"                :value :tabprevious :typet :vim_command }
  :<C-S-g>    { :desc "[!]float term"               :value "FloatermToggle!" :typet :vim_command }
  :<C-S-s>    { :desc "substitute +char +vmagic"    :value ":%s/\\v"                                   }
  :<C-Tab>    { :desc "next tab"                    :value :tabnext :typet :vim_command }
  :<C-n>      { :desc "[!]NerdTree"                 :value :NERDTreeToggle :typet :vim_command }
  :<C-s>      { :desc "substitute i"                :value ":%s/\\v\\c"                                }
  :<C-w>n     { :desc "new buffer right"            :value ":new<ESC><C-w>L"                           }
  :<ESC>      { :desc :clear                        :value ":noh<ESC>:echon \"\"<enter>"               }
  :?          { :desc "search +back +vmagic"        :value "?\\v\\c"                                   }
  :ZC         { :desc "delete buffer"               :value :bd :typet :vim_command }
  :ZG         { :desc "write quit all"              :value :wqall                   :typet :vim_command }
  :ZQ         { :desc "!quit all"                   :value :q!                      :typet :vim_command }
  :gne        { :desc "next function end"           :value :GotoNextFunctionEnd     :typet :vim_command }
  :|          { :desc "search nomagic"              :value "/\\V\\c"                                   }
  "]("        { :desc "previous ("                  :value "search('(', 'W')" :typet :vim_function }
  "])"        { :desc "previous )"                  :value "search(')', 'W')" :typet :vim_function }
  "[("        { :desc "next ("                      :value "search('(', 'bW')" :typet :vim_function }
  "[)"        { :desc "next )"                      :value "search(')', 'bW')" :typet :vim_function }
}
:t {
  :<C-S-g>    { :desc "[!]Float Term"             :value  "<C-w>:FloatermToggle!<ESC>"
                :remap true }
  :<C-w>      { :desc "normal mode"                 :value "<C-\\><C-n>"
                :remap true }
}
:v {
  :<C-S-s>    { :desc "sub +vmagic"                 :value ":s/\\%V\\v"                                }
  :<C-s>      { :desc "sub +i +vmagic"              :value ":s/\\%V\\v\\c"                             }
  "`"         { :desc ""                            :value :zf                                         }
}
[:c :i] {
  :<C-a>    { :desc "start of line"          :value :<home>     }
  :<C-b>    { :desc "backward char"          :value :<left>     }
  :<C-e>    { :desc "end of line"            :value :<end>      }
  :<C-f>    { :desc "forward char"           :value :<right>    }
  :<C-w>    { :desc "forward word"           :value :<S-right>  }
  :<C-S-w>  { :desc "backward word"          :value :<S-left>   }
  :<C-BS>   { :desc "delete word backwards"  :value :<C-w>      }
}
[ :n :v :t :i ] {
  :<C-1> { :desc "go to tab 1"    :value :1gt           }
  :<C-2> { :desc "go to tab 2"    :value :2gt           }
  :<C-3> { :desc "go to tab 3"    :value :3gt           }
  :<C-4> { :desc "go to tab 4"    :value :4gt           }
  :<C-5> { :desc "go to tab 5"    :value :5gt           }
  :<C-6> { :desc "go to tab 6"    :value :6gt           }
  :<C-7> { :desc "go to tab 7"    :value :7gt           }
  :<C-8> { :desc "go to tab 8"    :value :8gt           }
  :<C-9> { :desc "go to last tab" :value :tablast :typet :vim_command  }
}
})

(mod.register_binding_multiple REGULAR_MAPPINGS)
mod; }}}

; (fn mod.read_in_file [file]
;   (var lines {})
;   (each [l (io.lines file)]
;     (table.insert lines l))
;   lines)
;
; (fn mod.line_bind [start end lines]
;   )
;
; (fn mod.bindit [lines]
;   (local size (length lines))
;   (var i 1)
;   (while (<= i size)
;     (local l (. lines i))
;     (when (string.find l "^|.*|$" )
;       (mod.line_bind (+ i 2) size lines))
;     (set i (+ i 1))))
;
; (-> "mappings.md"
;  (mod.read_in_file)
;  (mod.bindit))
