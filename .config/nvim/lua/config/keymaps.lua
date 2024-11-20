-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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
