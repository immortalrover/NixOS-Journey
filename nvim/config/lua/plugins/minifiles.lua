return {
  "echasnovski/mini.files",
  version = '*',
  lazy = true,
  event = "VimEnter",
  dependencies = {
    { "echasnovski/mini.icons", opts = {} }
  },
  opts = {},
  keys = {
    { "<leader>e", ":lua MiniFiles.open()<cr>", desc = "打开文件树" }
  }
}
