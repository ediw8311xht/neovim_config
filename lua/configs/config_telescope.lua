local telescope_utils = require("telescope.utils")
local default_telescope_opts = {
  path_display = {
    size = 3,
  },
}
vim.g.telescope_opts = TableDifference(default_telescope_opts, vim.g.telescope_opts or {})

function RemoveBeginningPaths(path)
  local path_max = vim.g.telescope_opts.path_display.size
  local gsub = "^(.*/)(" .. string.rep("[^//]+/", path_max - 1) .. "[^//]*)$"
  local res

  path, res = path:gsub(Fmt("/home/%s/", ENV.USER), "")
  if res >= 1 then
    path, res = path:gsub(gsub, function(_, e)
      return e
    end)
  end
  return FS.basename(path), FS.dirname(path)
end

local function create_output_and_highlights(indexes)
  local highlight_tbl = {}
  local past = 0
  local conc = ""
  for _,v in ipairs(indexes) do
    table.insert(highlight_tbl, { { past }, v.hl })
    past = past + #v.str
    highlight_tbl[#highlight_tbl][1][2] =  past
    conc = conc .. v.str
  end

  return conc, highlight_tbl
end

local function my_path_display(opts, path)
  local highlights = {}
  local fullparent_path = FS.dirname(FS.abspath(path))
  local file_name = " " .. telescope_utils.path_tail(path) .. " "
  local path_head, path_tail = RemoveBeginningPaths(fullparent_path)
  local outlist = {
    { str = file_name or "", hl = "MyBlackOnGreen" },
    { str = GetPadding(file_name, math.min(30, API.nvim_win_get_width(0) / 4)), hl = "None" },
    { str = path_head or "", hl = "Comment"        },
    { str = "/",             hl = "Comment"        },
    { str = "  (",           hl = "None"           },
    { str = path_tail or "", hl = "Comment"        },
    { str = ")",             hl = "None"           },
  }
  return create_output_and_highlights(outlist)
end

MyTelescopeOpts = {
  defaults = {
    color_devicons = true,
    disable_devicons = false,
    dynamic_preview_title = true,
    disable_coordinates = true,
    path_display = my_path_display,
    multi_icon = "",
    layout_strategy = "horizontal",
    border = true,
    layout_config = {
      width = 0.95,
    },
    vimgrep_arguments = {
      "rg",
      "--no-config",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    mappings = {
      i = {
        ["<C-t>"] = require("telescope.actions.layout").toggle_preview,
        ["<C-S-t>"] = require("telescope.actions").select_tab,
        ["<C-g>"] = require("telescope.actions").preview_scrolling_down,
        ["<C-h>"] = require("telescope.actions").preview_scrolling_up,
        ["<C-d>"] = require("telescope.actions").results_scrolling_down,
        ["<C-u>"] = require("telescope.actions").results_scrolling_up,
        ["<C-s>"] = require("telescope.actions").select_horizontal,
        ["<C-v>"] = require("telescope.actions").select_vertical,
        ["<C-S-d>"] = require("telescope.actions").delete_buffer,
      },
    },
  },
}
-- require("telescope").setup(vim.g.telescope_opts)
require("telescope").setup(MyTelescopeOpts)
-- local builtin = require("telescope.builtin")
-- local themes = require("telescope.themes")
-- builtin.find_files(themes.get_ivy(vim.g.telescope_opts))
