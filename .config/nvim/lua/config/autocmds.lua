-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Fix: unable to delete the first character in Noice input popups.
-- mini.pairs remaps <BS> in insert mode, and its handler fails on the
-- last remaining character in Noice buffers. Override with plain <BS>.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "noice",
  callback = function(event)
    vim.keymap.set("i", "<BS>", "<BS>", { buffer = event.buf, noremap = true })
  end,
})
