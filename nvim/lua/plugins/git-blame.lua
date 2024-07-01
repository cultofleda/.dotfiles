return {
  "f-person/git-blame.nvim",
  lazy = true,
  event = "VeryLazy",
  setup = function()
    require("git-blame").setup({
      enabled = true,
    })
  end,
}
