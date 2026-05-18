
local cmd = vim.cmd
local fn = vim.fn
vim.g.journal_dir = fn.expand("$MY_JOURNAL")
vim.g.journal_template = fn.expand("$MY_JOURNAL/template.page")

function JournalFindCreateToday()
  local date = os.date("%Y_%m_%d")
  local relative_file = date .. ".page"
  local fullpath_file = fn.printf("%s/%s", vim.g.journal_dir, relative_file)
  vim.print(fullpath_file)
  if fn.filereadable(fullpath_file) ~= 1 then
    cmd["!"]("cp", vim.g.journal_template, fullpath_file)
    cmd["!"]("sed", "-i", fn.printf("'s/{DATE}/%s/g'", date), fullpath_file)
  end
  cmd.edit(fullpath_file)
end

function JournalFind()
  cmd.Files(vim.g.journal_dir)
end

local page_keymap_leader = {
  n = {
    Ax  = { desc="update gitit",         cmd='!$MY_WIKI/commit_push.sh --quick' },
    Aj  = { group="journal" },
    Ajs = { desc="find journal",         default=JournalFind },
    Ajj = { desc="open today's journal", default=JournalFindCreateToday },
  }
}
KeyMapSetter2(page_keymap_leader, "<leader>", true, true)
