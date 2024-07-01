-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("attach_colorizer"),
  -- only do this in "Frontend World:tm:"
  pattern = { "*.vue", "*.html", "*.scss", "*.css", "*.js", "*.ts", "*.jsx", "*.tsx", "*.txt", "*.md" },
  callback = function()
    local currentBuffer = vim.api.nvim_get_current_buf()
    local colorizer = require("colorizer")
    -- not sure if this is the right way to do it but fuck it
    colorizer.attach_to_buffer(currentBuffer, { mode = "background", css = "true" })
  end,
})
