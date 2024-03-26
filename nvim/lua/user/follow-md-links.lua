
local M = {
    "jghauser/follow-md-links.nvim",
    ft = { "markdown" },
}

function M.config()
  vim.keymap.set('n', '<bs>', ':edit #<cr>', { silent = true })
end

return M
