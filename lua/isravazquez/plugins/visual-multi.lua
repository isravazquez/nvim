return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "VeryLazy",
  init = function()
    -- Keep default mappings (Ctrl+n, etc.) which do not collide with your <leader> maps.
    vim.g.VM_default_mappings = 1
    -- Start multicursor from visual mode with Ctrl+n over selection.
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
    }
  end,
}
