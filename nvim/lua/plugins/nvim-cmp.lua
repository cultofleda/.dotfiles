return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    table.insert(opts.sources, {
      { name = "cmp_tabnine", group_index = 1, priority = 100 },
      { name = "emoji" },
      { name = "nvim_lsp", priority = 1000 },
      -- { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
    })
  end,
}
