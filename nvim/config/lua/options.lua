local o = vim.opt
local g = vim.g

local function setup()
  -- Display Options
  o.number = true
  o.hlsearch = true
  o.incsearch = true
  o.cursorline = true
  o.termguicolors = true
  -- Indentation and Tabs
  o.tabstop = 4
  o.shiftwidth = 4
  o.expandtab = true
  o.smarttab = true
  o.softtabstop = 4
  -- Other
  o.encoding = "utf-8"
  o.list = true
  o.listchars = {
    space = '·',
    trail = '-',
  }
end
return setup()
