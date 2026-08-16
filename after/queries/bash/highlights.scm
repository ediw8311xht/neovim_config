;; extends

(variable_assignment
  name: (variable_name)
  value: (word) @custom.bash.boolean
  (#any-of? @custom.bash.boolean "true" "false"))

(command
  name: (_)
  argument: (word) @custom.bash.boolean
  (#any-of? @custom.bash.boolean "true" "false"))

