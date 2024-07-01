return {
  "norcalli/nvim-colorizer.lua",
  lazy = true,
  event = "VeryLazy",
  config = function()
    local colorizer = require("colorizer")
    colorizer.setup()
    colorizer.attach_to_buffer(0, { mode = "background", css = "true" })
  end,
}
