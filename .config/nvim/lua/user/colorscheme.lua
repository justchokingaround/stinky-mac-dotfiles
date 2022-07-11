local colorscheme = "gruvbox"
-- local colorscheme = "darkplus"
-- local colorscheme = "edge"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
