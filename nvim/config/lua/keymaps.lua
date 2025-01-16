-- space bar leader key
vim.g.mapleader = " "

-- yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
