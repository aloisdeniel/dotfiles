return {
  {
    "folke/snacks.nvim",
    opts = {
      input = { enabled = false },
      picker = {
        config = function(opts)
          opts.cwd = LazyVim.root.git()
          return opts
        end,
      },
    },
  },
}
