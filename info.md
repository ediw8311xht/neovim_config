---
categories: nvim editor vimscript lua
title: nvim info
toc: true
---



- get visual selection
  - example
    ``` lua
    function GetVisualSelection()
      local region_post = vim.fn.getregionpos(vim.fn.getpos('v'),
                                              vim.fn.getpos('.'))
      local col = ""
      for _, i in ipairs(region_post) do
        col = col .. table.concat(vim.fn.getregion(i[1], i[2]), '\n') .. '\n'
      end
      return col
    end
    vim.keymap.set(
      "v",
      "<leader>g",
      "<CMD>lua visual_get = GetVisualSelection()<CR>",
      {remap=false, desc=""}
    )
    ```
- lsp
  - workspace
    - add workspace folder
    - comm `vim.lsp.buf.add_workspace_folder()`
      ``` help
      Add the folder at path to the workspace folders. If {path} is not
      provided, the user will be prompted for a path using |input()|.

      Parameters: ~
        • {workspace_folder}  (`string?`)
      ```
  - locations `vim.lsp.LocationOpts`
  - floating preview `vim.lsp.util.open_floating_preview.Opts`
- undo/redo
  - to to previous or latest change

    - | meaning                                                                          | command             | args           |
      |----------------------------------------------------------------------------------|---------------------|----------------|
      | Go to older/newer text state {count} times.                                      | `:earlier`/`:later` | `count`        |
      | Go to older/newer text state about {N} seconds before (secs\|mins\|hours\|days). | `:earlier` `:later` | `[0-9]+[smdh]` |

  - .
