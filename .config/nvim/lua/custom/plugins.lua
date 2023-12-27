local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- markdown preview
  {
    "ellisonleao/glow.nvim",
    lazy = false,
    config = function ()
      require('glow').setup({
        style = "dark",
        width = 120,
      })
    end,
    cmd = "Glow"
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
  {
    'tpope/vim-surround',
    lazy = false
  },
  {
    'FabijanZulj/blame.nvim',
    lazy = false,
    config = function()
      require('blame').setup({
        width = 50,
        merge_consecutive = true,
      })
    end
  },
  {
    'lewis6991/spaceless.nvim',
    lazy = false,
    config = function()
      require'spaceless'.setup()
    end
  }
}
return plugins
