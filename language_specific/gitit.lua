vim.g.journal_dir = vim.fn.expand("$MY_JOURNAL")
vim.g.journal_template = vim.fn.expand("$MY_JOURNAL/template.page")

function JournalFindCreateToday()
  local date = os.date("%Y_%m_%d")
  local relative_file = date .. ".page"
  local fullpath_file = vim.fn.printf("%s/%s", vim.g.journal_dir, relative_file)
  vim.print(fullpath_file)
  if vim.fn.filereadable(fullpath_file) ~= 1 then
    vim.cmd["!"]("cp", vim.g.journal_template, fullpath_file)
    vim.cmd["!"]("sed", "-i", vim.fn.printf("'s/{DATE}/%s/g'", date), fullpath_file)
  end
  vim.cmd.edit(fullpath_file)
end

function JournalFind()
  vim.cmd.Files(vim.g.journal_dir)
end

local page_keymap_leader = {
  n = {
    Ax = {
      desc = "update gitit",
      default = function()
        ExecuteScript( "commit_push.sh", { path = vim.fn.getenv("MY_WIKI"), quiet=true }, "--quick" )
        ExecuteScript("refresh_browser.sh")
      end,
    }, -- cmd='!$MY_WIKI/commit_push.sh --quick' },
    Aj  = { group = "journal" },
    Ajs = { desc = "find journal", default = JournalFind },
    Ajj = { desc = "open today's journal", default = JournalFindCreateToday },
  },
}
KeyMapSetter2(page_keymap_leader, "<leader>", true, true)
