return { -- An arctic, north-bluish color
  "shaunsingh/nord.nvim",
  lazy = false,
  priority = 1000,
  config = function ()
    vim.cmd('colorscheme nord')
  end
}
