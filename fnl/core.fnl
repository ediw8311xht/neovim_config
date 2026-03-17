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
                           : with_leader}]
  (local with_leader (= with_leader true))
  (local remap  (= remap true))
  (var typet (or typet :normal))
  (var key (or (and with_leader (.. "," key)) key))
  (var value value)
  (case (string.lower typet)
    :cmd (set value (.. :<CMD> value :<CR>))
    :vim_command (set value (.. ":" value :<CR>))
    :vim_function (set value (.. ":call " value :<CR>))
    :lua (set value (.. ":lua " value :<CR>))
    :normal nil)
  (vim.keymap.set mode key value {: desc : remap : expr})
  (when (and which_key with_which_key)
    (which_key.add {1 key : desc : mode})))

(fn mod.register_binding_multiple [base_table]
  (each [mode sub_table (pairs base_table)]
    (each [key mapping (pairs sub_table)]
      (mod.register_binding {: key : mode} mapping))))


(global REGULAR_MAPPINGS {
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
  :<C-S-b>    { :desc "Backward whole word"         :value :<C-o>B                                     }
  :<C-S-f>    { :desc "Forward whole word"          :value :<C-o>W                                     }
  :<C-S-g>    { :desc "New undo point"              :value :<C-g>u                                     }
  :<C-S-k>    { :desc "Delete to end of line"       :value :<C-g>u<C-o>D                               }
  :<C-S-t>    { :desc "Remove indent"               :value :<C-d>                                      }
  :<C-S-u>a   { :desc "New undo point"              :value :<C-g>u                                     }
  :<C-S-u>r   { :desc :Redo                         :value :<C-o><C-r>                                 }
  :<C-S-u>u   { :desc :Undo                         :value :<C-o>u                                     }
  :<C-u>      { :desc "Del entered chars b4 curs"   :value :<C-g>u<C-u>                                }
  :jk         { :desc "Exit Insert[m ]"             :value :<ESC>                                      }
}
:n {
  :/          { :desc "Search vmagic"               :value "/\\v\\c"                                   }
  :<C-S-E>    { :desc "End of previous word"        :value :ge                                         }
  :<C-S-H>    { :desc "Left pane"                   :value :<C-w>h                                     }
  :<C-S-J>    { :desc "Down pane"                   :value :<C-w>j                                     }
  :<C-S-K>    { :desc "Up Pane"                     :value :<C-w>k                                     }
  :<C-S-L>    { :desc "Right pane"                  :value :<C-w>l                                     }
  :<C-S-Tab>  { :desc "Previous tab"                :value :tabprevious
                :typet :vim_command }
  :<C-S-g>    { :desc "! Floating Term"             :value ":FloatermToggle!<ESC>"                     }
  :<C-S-s>    { :desc "Substitute +char +vmagic"    :value ":%s/\\v"                                   }
  :<C-Tab>    { :desc "Next tab"                    :value :tabnext                                    
                :typet :vim_command }
  :<C-n>      { :desc "+Nerd Tree"                  :value :NERDTreeToggle                             
                :typet :vim_command }
  :<C-s>      { :desc "Substitute i"                :value ":%s/\\v\\c"                                }
  :<C-w>n     { :desc "New Buffer Right"            :value ":new<ESC><C-w>L"                           }
  :<ESC>      { :desc :Clear                        :value ":noh<ESC>:echon \"\"<enter>"               }
  :?          { :desc "Search +back +vmagic"        :value "?\\v\\c"                                   }
  :ZC         { :desc "Delete Buffer"               :value ":bd<ESC>"                                  }
  :ZG         { :desc "Write quit all"              :value :wqall                                      
                :typet :vim_command }
  "`"         { :desc :Fold                         :value "@=(foldlevel('.')?'za':\"<Space>\")<CR>"   }
  :gne        { :desc "Next Function End"           :value :GotoNextFunctionEnd                        
                :typet :vim_command }
  "{"         { :desc "Prev Function Start"         :value :GotoPrevFunctionStart                      
                :typet :vim_command }
  :|          { :desc "Search nomagic"              :value "/\\V\\c"                                   }
  "}"         { :desc "Next Function Start"         :value :GotoNextFunctionStart                      
                :typet :vim_command }
}
:t {
  :<C-S-g>    { :desc "! Floating Term"             :value  "<C-w>:FloatermToggle!<ESC>"               
                :remap true }
  :<C-w>      { :desc "Normal Mode"                 :value "<C-\\><C-n>"                               
                :remap true }
}
:v {
  :<C-S-s>    { :desc "Sub +vmagic"                 :value ":s/\\%V\\v"                                }
  :<C-s>      { :desc "Sub +i +vmagic"              :value ":s/\\%V\\v\\c"                             }
  "`"         { :desc ""                            :value :zf                                         }
}
[:c :i] {
     :<C-a>    { :desc "Start of line"          :value :<home>     }
     :<C-b>    { :desc "Backward char"          :value :<left>     }
     :<C-e>    { :desc "End of line"            :value :<end>      }
     :<C-f>    { :desc "Forward char"           :value :<right>    }
     :<C-w>    { :desc "Forward word"           :value :<S-right>  }
     :<C-S-w>  { :desc "Backward word"          :value :<S-left>   }
     :<C-BS>   { :desc "Delete word backwards"  :value :<C-w>      }
}
})

(mod.register_binding_multiple REGULAR_MAPPINGS)
mod
