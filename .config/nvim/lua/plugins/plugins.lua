-- since this is just an example spec, don't actually load anything here and return an empty spec
return {
  { "echasnovski/mini.nvim", version = "*" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "dart",
        "bash",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "regex",
        "templ",
      },
      indent = { enable = true, disable = { "dart" } },
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
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      "mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    opts = function()
      local ret = {
        diagnostics = {},
        inlay_hints = {
          enabled = true,
        },
        codelens = {
          enabled = true,
        },
        document_highlight = {
          enabled = true,
        },
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        servers = {
          dartls = {

            mason = false,
            cmd = {
              "dart",
              "language-server",
              "--protocol=lsp",
            },
            filetypes = { "dart" },
            init_options = {
              onlyAnalyzeProjectsWithOpenFiles = false,
              suggestFromUnimportedLibraries = true,
              closingLabels = true,
              outline = false,
              flutterOutline = false,
            },
            settings = {
              dart = {
                analysisExcludedFolders = {
                  vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
                  vim.fn.expand("$HOME/.pub-cache"),
                  vim.fn.expand("/opt/homebrew/"),
                  vim.fn.expand("$HOME/tools/flutter/"),
                },
                updateImportsOnRename = true,
                completeFunctionCalls = true,
                showTodos = true,
              },
            },
          },

          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
        },
        setup = {},
      }
      return ret
    end,
  },
}
