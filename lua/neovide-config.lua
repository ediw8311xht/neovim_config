

if vim.g.neovide then
  -- vim.g.neovide_text_contrast = 0.5
  -- vim.g.neovide_pixel_geometry = "RGBH"
  -- vim.g.neovide_profiler = true
  vim.o.guifont = "Agave:h12"
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_opacity = 0.8
  vim.g.neovide_normal_opacity = 0.2

  vim.g.neovide_leader_mapping = {
    n = {
      N = { group = "neovide" },
      Np = { desc="[!] profiler", default=CreateToggleOpt("profiler", "g"), },
    }

  }
  KeyMapSetter2(vim.g.neovide_leader_mapping, "<leader>", false, true)

end

