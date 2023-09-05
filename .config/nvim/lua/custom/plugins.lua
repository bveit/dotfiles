local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   lazy = false,
  --   opts = function ()
  --     return require "custom.configs.copilot"
  --   end,
  --   config = function(_, opts)
  --     require("copilot").setup(opts)
  --   end
  -- },
  -- {
  --   "anuvyklack/pretty-fold.nvim",
  --   lazy = false,
  --   config = function()
  --     require("pretty-fold").setup()
  --   end
  -- },
  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "python-lsp-server",
  --     },
  --   },
  -- },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
}
return plugins
