-- The <Leader> key.
vim.g.mapleader = ","

-- Reset search highlight on `Enter`.
vim.keymap.set("n", "<CR>", ":nohlsearch<CR>", {
  noremap = true,
  silent = true,
})

vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", {
  noremap = true,
})
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>", {
  noremap = true,
})
vim.keymap.set("n", "<Leader>fb", ":Telescope buffers<CR>", {
  noremap = true,
})
vim.keymap.set("n", "<Leader>fh", ":Telescope help_tags<CR>", {
  noremap = true,
})
