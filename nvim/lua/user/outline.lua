
local M = {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    lazy = false,
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>o"] = { "<cmd>Outline<CR>", "Toggle Outline" },
  }

  require("outline").setup{}
end

return M

