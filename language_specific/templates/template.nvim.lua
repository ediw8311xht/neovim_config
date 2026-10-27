--[[
  defining project specific variables
--]]
vim.g.Project_directory = vim.fn.expand("")
vim.g.Lisp_directories = { vim.g.project_directory, }
vim.g.Lisp_systems = { "" }
vim.g.Lisp_test_system = ""
vim.g.Lisp_session_system = ""
vim.g.Lisp_saved_forms = {
  "()",
}
