return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          vim.api.nvim_buf_set_keymap(buf,
            "n",
            "<leader>gf",
            "<cmd>lua vim.lsp.buf.format()<cr>",
            { noremap = true, desc = "格式化代码" }
          )
        end,
      })
      local lspconfig = require("lspconfig")
      lspconfig["lua_ls"].setup({})
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons",     -- optional
    },
    opts = {
      lightbulb = {
        enable = true,
        sign = false,
      },
      outline = {
        close_after_jump = true,
        layout = 'float',
        left_width = 0.5,
      },
    },
    keys = {
      { "<leader>gc", "<cmd>Lspsaga code_action<cr>",     desc = "code_action" },
      { "<leader>gk", "<cmd>Lspsaga peek_definition<cr>", desc = "peek_definition" },
      { "<leader>gr", "<cmd>Lspsaga rename<cr>",          desc = "rename" },
      { "<leader>gl", "<cmd>Lspsaga outline<cr>",         desc = "outline" },
      { "K",          "<cmd>Lspsaga hover_doc<cr>",       desc = "hover_doc" },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
    },
    config = function()
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = true,
                })
              end
            else
              fallback()
            end
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        -- 使用lspkind-nvim显示类型图标
        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 50,
            before = function(entry, vim_item)
              -- Source 显示提示来源
              vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
              return vim_item
            end
          })
        },
      })
      -- load vscode snippet (friendly-snippet)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
