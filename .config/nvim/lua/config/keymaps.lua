-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Function to start Flutter run task with a prompt for cwd
local function flutter_run()
  vim.ui.input({
    prompt = "Enter project directory for Flutter Run: ",
    default = vim.fn.getcwd(),
  }, function(cwd)
    if cwd then
      local overseer = require("overseer")
      local task = overseer.new_task({
        name = "Flutter Run",
        cmd = { "flutter" },
        args = { "run" },
        cwd = cwd,
      })
      task:start()
      overseer.open()
    end
  end)
end

-- Function to send a key to flutter task
local function flutter_input(i)
  local tasks = require("overseer").list_tasks()
  for _, task in pairs(tasks) do
    if task and task.name == "Flutter Run" then
      task:send(i)
    end
  end
end

-- Commands
vim.api.nvim_create_user_command("FlutterRun", function()
  flutter_run()
end, {})

vim.api.nvim_create_user_command("FlutterHotReload", function()
  flutter_input("r")
end, {})

vim.api.nvim_create_user_command("FlutterHotRestart", function()
  flutter_input("R")
end, {})

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>ofr", ":FlutterRun<CR>", {
  desc = "Start Flutter run task",
  noremap = true,
  silent = true,
})

vim.api.nvim_set_keymap("n", "<leader>ofh", ":FlutterHotReload<CR>", {
  desc = "Send hot reload 'r' to Flutter task",
  noremap = true,
  silent = true,
})

vim.api.nvim_set_keymap("n", "<leader>oft", ":FlutterHotRestart<CR>", {
  desc = "Send hot reload 'R' to Flutter task",
  noremap = true,
  silent = true,
})
