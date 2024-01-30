return {
  {
    "marko-cerovac/material.nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = function()
      vim.g.material_style = "darker"
      return {
        colorscheme = "material",
      }
    end,
  },
}
