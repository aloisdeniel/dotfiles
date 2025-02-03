-- since this is just an example spec, don't actually load anything here and return an empty spec
return {
  { "echasnovski/mini.nvim", version = "*" },
  {
    "gbprod/yanky.nvim",
    opts = {
      highlight = { timer = 150 },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = { style = "night" },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
        },
        bind_to_cwd = true,
        follow_current_file = { enabled = false },
      },
      window = {
        position = "float",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "dart",
        "bash",
        "html",
        "json",
        "lua",
        "ruby",
        "markdown",
        "markdown_inline",
        "regex",
        "templ",
      },
      indent = { enable = true, disable = { "dart", "ruby" } },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "templ",
      },
    },
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      custom_filetypes = {
        "templ",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        mappings = {
          n = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
          },
          i = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
          },
        },
      },
    },
  },
}
