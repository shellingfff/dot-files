-- nvim-tree
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "[F]ind Buffer" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Go to References" })

local lsp_normal_mappings = {
	{ key = "gK", cmd = vim.lsp.buf.hover, desc = "Show hover" },
	{ key = "gd", cmd = vim.lsp.buf.definition, desc = "Go to Definition" },
	{ key = "gD", cmd = vim.lsp.buf.declaration, desc = "Go to Declaration" },
	--{ key = "gr", cmd = vim.lsp.buf.references, desc = "Go to References" },
	{ key = "gI", cmd = vim.lsp.buf.implementation, desc = "Go to Implementation" },
	{ key = "se", cmd = vim.diagnostic.open_float, desc = "Show diagnostic [E]rror messages" },
}

for _, map in ipairs(lsp_normal_mappings) do
	vim.keymap.set("n", map.key, map.cmd, { desc = map.desc })
end

