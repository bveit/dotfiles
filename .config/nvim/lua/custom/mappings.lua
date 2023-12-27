local M = {}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
  }
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["§"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["§"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.blame = {
  n = {
    ["<leader>gb"] = { ":ToggleBlame<CR><C-h>", "Toggle Blame" },
    -- ["<leader>gbe"] = { ":EnableBlame<CR>:wincmd p<CR>", "Enable Blame" },
    -- ["<leader>gbd"] = { ":DisableBlame<CR>", "Disable Blame" },
  }
}
return M
