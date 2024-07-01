return {
  {
    "AlexvZyl/nordic.nvim",
    as = "nordic",
    lazy = true,
    config = function()
      require("nordic").load()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nordic",
    },
  },
}
