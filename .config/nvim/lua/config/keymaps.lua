-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Flutter commands
vim.api.nvim_create_user_command("FlutterRun", function(opts)
  -- Open a new wezterm pane on the right
  local command = "wezterm cli split-pane --right --percent 30 --cwd '"
    .. opts.args
    .. "' -- bash -c 'flutter run; exec bash'"

  -- Run the command to create the new pane and capture the pane ID
  local handle = io.popen(command)
  if handle ~= nil then
    local result = handle:read("*a")
    handle:close()

    -- Assuming the pane ID is printed after the pane is created
    -- Here you would normally extract the pane ID from the command output if necessary.
    -- In case you need to get pane details use `wezterm cli list --format json`.
    wezterm_pane_id = result:match("%d+") -- Extract pane ID
  end
end, { nargs = 1 })

vim.api.nvim_create_user_command("FlutterInput", function(input)
  if wezterm_pane_id then
    -- Send input to the stored pane ID
    local send_command = "wezterm cli send-text --pane-id " .. wezterm_pane_id .. " '" .. input.args .. "'"
    os.execute(send_command)
  else
    print("Error: No WezTerm pane created yet. Run :FlutterRun first.")
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
