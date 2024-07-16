return {
  {
    "cultofleda/rasmus.nvim",
    dir = "/home/avazigin/Git/cultofleda/rasmus.nvim",
    dev = true,
    config = function()
      vim.g.rasmus_italic_functions = true
      vim.g.rasmus_variant = "dark"
      vim.g.rasmus_italic_keywords = true
      -- this comment should be italic, and it is
      vim.cmd("colorscheme rasmus")
      vim.cmd(":set fillchars+=vert:⠀")
    end,
  },
}
