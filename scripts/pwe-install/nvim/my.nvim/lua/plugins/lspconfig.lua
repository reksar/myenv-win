return {
  "neovim/nvim-lspconfig",
  ft = {
    "python",
  },
  config = function()
    require("lspconfig").pylsp.setup({
      filetypes = {"python"},
    })
  end,
}
