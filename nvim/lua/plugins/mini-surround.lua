return {
  "echasnovski/mini.surround",
  opts = {
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
    custom_surroundings = {
      ["<"] = {
        input = function()
          local tag = MiniSurround.user_input("Tag to wrap selection in: ")
          return { tag .. "().-()" .. tag }
        end,
        output = function()
          local tag = MiniSurround.user_input("Tag to wrap selection in: ")
          local left = string.format("<%s>", tag)
          local right = string.format("</%s>", tag)
          return { left = left, right = right }
        end,
      },
    },
  },
}
