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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
        },
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
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
