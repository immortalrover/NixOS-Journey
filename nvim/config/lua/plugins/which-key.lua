return {
  "folke/which-key.nvim",
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    { "echasnovski/mini.icons", opts = {} }
  },
  opts = {},
  -- keys = { -- 我认为不需要设置这个
  --   {
  --     "<leader>?",
  --     function()
  --       require("which-key").show({ global = false })
  --     end,
  --     desc = "Buffer Local Keymaps (which-key)",
  --   },
  -- },
}
