(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(import-macros { : register_binding : register_binding_multiple } :macros)

(local mod {})

(register_binding_multiple {} {
"" {
  :+          { :desc "End of line"                 :val :g_ 
                :remap true }
  ","         { :desc :<leader>                     :val :<leader>
                :remap true }
  ",;"        { :desc "prev motion backwards"       :val ","  }
  "<enter>"   { :desc "prev motion backwards"       :val ","  }
  :x          { :desc "[delete] character"          :val "\"xx"  }
}
:c {
  :<C-S-k>    { :desc ""                            :val :<C-c>D<C-c>  }
}
:i {
  :<C-S-b>    { :desc "backward whole word"          :val :<C-o>B  }
  :<C-S-f>    { :desc "forward whole word"           :val :<C-o>W  }
  :<C-S-g>    { :desc "new undo point"               :val :<C-g>u  }
  :<C-S-k>    { :desc "delete to end of line"        :val :<C-g>u<C-o>D  }
  :<C-S-t>    { :desc "remove indent"                :val :<C-d>  }
  :<C-S-u>a   { :desc "new undo point"               :val :<C-g>u  }
  :<C-S-u>r   { :desc :redo                          :val :<C-o><C-r>  }
  :<C-S-u>u   { :desc :undo                          :val :<C-o>u  }
  :<C-u>      { :desc "[delete] chars before cursor" :val :<C-g>u<C-u>  }
  :jk         { :desc "exit Insert[m ]"              :val :<ESC>  }
}
:n {
  "`"         { :desc :fold                         :val "@=(foldlevel('.')?'za':\"<Space>\")<CR>"  }
  :/          { :desc "search vmagic"               :val "/\\v\\c"  }
  :<C-S-E>    { :desc "end of previous word"        :val :ge  }
  :<C-S-H>    { :desc "left pane"                   :val :<C-w>h  }
  :<C-S-J>    { :desc "down pane"                   :val :<C-w>j  }
  :<C-S-K>    { :desc "up Pane"                     :val :<C-w>k  }
  :<C-S-L>    { :desc "right pane"                  :val :<C-w>l  }
  :<C-S-Tab>  { :desc "previous tab"                :val :tabprevious :typet :vim_command  }
  :<C-S-g>    { :desc "[!]float term"               :val "FloatermToggle" :typet :vim_command  }
  :<C-S-s>    { :desc "substitute +char +vmagic"    :val ":%s/\\v"  }
  :<C-Tab>    { :desc "next tab"                    :val :tabnext :typet :vim_command  }
  :<C-n>      { :desc "[!]NerdTree"                 :val :NERDTreeToggle :typet :vim_command  }
  :<C-s>      { :desc "substitute i"                :val ":%s/\\v\\c"  }
  :<C-w>n     { :desc "new buffer right"            :val  :new<ESC><C-w>L  }
  :<esc>      { :desc :clear                        :val  :nohlsearch :typet :cmd  }
  ; :<C-esc>    { :desc :clear-all                    :val  :<C-l> :silent true  }
  :?          { :desc "search +back +vmagic"        :val "?\\v\\c"  }
  :ZC         { :desc "delete buffer"               :val :bd :typet :vim_command  }
  :ZG         { :desc "write quit all"              :val :wqall                   :typet :vim_command  }
  :ZQ         { :desc "!quit all"                   :val :q!                      :typet :vim_command  }
  :gne        { :desc "next function end"           :val :GotoNextFunctionEnd     :typet :vim_command  }
  :|          { :desc "search nomagic"              :val "/\\V\\c"  }
}
:t {
  :<C-S-g>    { :desc "[!]Float Term"               :val  "<C-w>:FloatermToggle<ESC>"
                :remap true  }
  :<C-w>      { :desc "normal mode"                 :val "<C-\\><C-n>"
                :remap true  }
}
:v {
  :<C-S-s>    { :desc "sub +vmagic"                 :val ":s/\\%V\\v"  }
  :<C-s>      { :desc "sub +i +vmagic"              :val ":s/\\%V\\v\\c"  }
  "`"         { :desc "toggle fold"                 :val :zf  }
}
[:n :v] {
  "](" { :desc "previous ("  :val "search('(', 'Wsz')"  :typet :vim_function  }
  "])" { :desc "previous )"  :val "search(')', 'Wsz')"  :typet :vim_function  }
  "[(" { :desc "next ("      :val "search('(', 'bWsz')" :typet :vim_function  }
  "[)" { :desc "next )"      :val "search(')', 'bWsz')" :typet :vim_function  }
}
[:x :n] {
  :ga       { :desc "easy align" :val "<Plug>(EasyAlign)"  }
}
[:c :i] {
  :<C-a>    { :desc "start of line"          :val :<home>  }
  :<C-b>    { :desc "backward char"          :val :<left>  }
  :<C-e>    { :desc "end of line"            :val :<end>  }
  :<C-f>    { :desc "forward char"           :val :<right>  }
  :<C-w>    { :desc "forward word"           :val :<S-right>  }
  :<C-S-w>  { :desc "backward word"          :val :<S-left>  }
  :<C-BS>   { :desc "delete word backwards"  :val :<C-w>  }
}
[ :n :v :t :i ] {
  :<C-1> { :desc "go to tab 1"    :val :1gt  }
  :<C-2> { :desc "go to tab 2"    :val :2gt  }
  :<C-3> { :desc "go to tab 3"    :val :3gt  }
  :<C-4> { :desc "go to tab 4"    :val :4gt  }
  :<C-5> { :desc "go to tab 5"    :val :5gt  }
  :<C-6> { :desc "go to tab 6"    :val :6gt  }
  :<C-7> { :desc "go to tab 7"    :val :7gt  }
  :<C-8> { :desc "go to tab 8"    :val :8gt  }
  :<C-9> { :desc "go to last tab" :val :tablast :typet :vim_command }
}
[ :n :x :o ] {
  "{"   { :desc "prev function start" :val "require('nvim-treesitter-textobjects.move').goto_previous_start('@fn_decl.outer', 'textobjects')" :typet :cmd_lua  }
  "}"   { :desc "next function start" :val "require('nvim-treesitter-textobjects.move').goto_next_start('@fn_decl.outer', 'textobjects')"     :typet :cmd_lua  }
}
})

mod

; (fn mod.read_in_file [file] {{{
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
;  (mod.bindit)) }}}
