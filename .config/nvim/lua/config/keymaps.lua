-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function tmux_command(command)
  local tmux_socket = vim.fn.split(vim.env.TMUX, ",")[1]
  return vim.fn.system("tmux -S " .. tmux_socket .. " " .. command)
end

local function tmux_window_exists(name)
  local windows = tmux_command("list-windows")
  local index = string.find(windows, ": " .. name)
  return index ~= nil and index >= 0
end

-- Flutter commands
vim.api.nvim_create_user_command("FlutterRun", function(opts)
  local window_exists = tmux_window_exists("flutter")
  if not window_exists then
    tmux_command("new-window -n flutter -c '" .. opts.args .. "' bash -c 'flutter run; exec bash'")
    vim.notify("Flutter run started!", vim.log.levels.INFO)
  else
    vim.notify("Error: No Tmux window named 'flutter' found. Run :FlutterRun first.", vim.log.levels.ERROR)
  end
end, { nargs = 1 })

vim.api.nvim_create_user_command("FlutterInput", function(input)
  local window_exists = tmux_window_exists("flutter")
  if window_exists then
    local send_command = "send-keys -t flutter '" .. input.args .. "' Enter"
    tmux_command(send_command)
    vim.notify("Flutter input '" .. input.args .. "' sent!", vim.log.levels.INFO)
  else
    vim.notify("Error: No Tmux window named 'flutter' found. Run :FlutterRun first.", vim.log.levels.ERROR)
  end
end, { nargs = 1 })

-- Keymaps
--
vim.keymap.set("n", "<leader>rs", function()
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

vim.api.nvim_set_keymap("n", "<leader>rr", ":FlutterInput r<CR>", {
  desc = "Hot reload. 🔥🔥🔥",
  noremap = true,
  silent = true,
})

vim.api.nvim_set_keymap("n", "<leader>rR", ":FlutterInput R<CR>", {
  desc = "Hot restart.",
  noremap = true,
  silent = true,
})

vim.api.nvim_set_keymap("n", "<leader>rq", ":FlutterInput q<CR>", {
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
