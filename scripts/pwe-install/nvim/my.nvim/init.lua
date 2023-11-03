-- UI -- {{{
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.colorcolumn = "80"
vim.opt.foldmethod = "marker"
vim.opt.guitablabel = "%t"  -- Show file name only
vim.g.netrw_list_style = 3
vim.g.netrw_browse_split = 3
-- }}}

-- File Types -- {{{
for _, filetype in ipairs({
  "vim",
  "lua",
  "sh",
  "dosbatch",
  "cpp",
  "xml",
  "html",
  "yaml",
  "json",
}) do
  vim.cmd("autocmd FileType "..filetype.." set tabstop=2")
  vim.cmd("autocmd FileType "..filetype.." set shiftwidth=2")
end
-- }}}

local is_windows = vim.fn.has("win32") == 1
vim.opt.clipboard = is_windows and "unnamed" or "unnamedplus"
vim.opt.swapfile = false

-- To `:find` files in subdirs recursively.
vim.opt.path:append({"**"})
-- Display matchind files on <Tab>.
vim.opt.wildmenu = true

vim.opt.langmenu = "en_US.UTF-8"
vim.api.nvim_exec("language en_US.UTF-8", true)

-- Nvim scpecific -- {{{
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
-- }}}

require("keymap")
require("plugins_init")
