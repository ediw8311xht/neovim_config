--[[
  defining project specific variables
--]]
vim.g.project_directory = vim.fn.expand("")
vim.g.lisp_directories = { vim.g.project_directory, }
vim.g.lisp_systems = { "" }
vim.g.lisp_test_system = ""
vim.g.lisp_session_system = ""
vim.g.lisp_saved_forms = {
  "()",
}
