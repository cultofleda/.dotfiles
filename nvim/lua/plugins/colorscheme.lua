return {
  {
    "marko-cerovac/material.nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = function()
      vim.g.material_style = "oceanic"
      return {
        colorscheme = "material",
      }
    end,
  },
}
