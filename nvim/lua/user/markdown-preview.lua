
local M = {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
}

function M.config()
  -- vim.g.mkdp_browser =  "/etc/profiles/per-user/nix/bin/firefox"
  vim.g.mkdp_auto_start = 0

  local wk = require "which-key"
  wk.register {
    ["<leader>md"] = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
  }
end

return M

