-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Flutter commands
vim.api.nvim_create_user_command("FlutterRun", function(opts)
  local overseer = require("overseer")
  local task = overseer.new_task({
    name = "Flutter Run",
    cmd = { "flutter" },
    args = { "run" },
    cwd = opts.args,
  })
  task:start()
  overseer.open()
end, { nargs = 1 })

vim.api.nvim_create_user_command("FlutterInput", function(opts)
  local tasks = require("overseer").list_tasks()
  for _, task in pairs(tasks) do
    if task and task.name == "Flutter Run" then
      local chan_id = task.strategy.chan_id
      vim.api.nvim_chan_send(chan_id, opts.args)
    end
  end
end, { nargs = 1 })

-- Keymaps
--
vim.keymap.set("n", "<leader>off", function()
  vim.ui.input({ prompt = "In which directory?", default = vim.fn.getcwd() }, function(input)
    if input then
      vim.cmd("FlutterRun " .. input)
    end
  end)
end, {
  desc = "Start the app.",
  noremap = true,
  silent = true,
})

vim.api.nvim_set_keymap("n", "<leader>ofr", ":FlutterInput r<CR>", {
  desc = "Hot reload. 🔥🔥🔥",
  noremap = true,
  silent = true,
})

vim.api.nvim_set_keymap("n", "<leader>ofR", ":FlutterInput R<CR>", {
  desc = "Hot restart.",
  noremap = true,
  silent = true,
})

vim.api.nvim_set_keymap("n", "<leader>ofq", ":FlutterInput q<CR>", {
  desc = "Quit (terminate the application on the device).",
  noremap = true,
  silent = true,
})

vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")
