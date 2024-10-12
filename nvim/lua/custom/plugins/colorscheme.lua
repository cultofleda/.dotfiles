return {
  'folke/tokyonight.nvim',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'tokyonight'
    vim.cmd.hi 'Comment gui=none'
  end,
}
