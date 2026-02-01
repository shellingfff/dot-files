-- line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

vim.opt.fileencodings = { "utf-8" }
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- nerd font
vim.g.have_nerd_font = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Use H/L to switch between buffers
vim.keymap.set("n", "H", "<cmd>bp<CR>")
vim.keymap.set("n", "L", "<cmd>bn<CR>")

vim.keymap.set("n", "gh", "<cmd>normal!H<CR>")
vim.keymap.set("n", "gl", "<cmd>normal!L<CR>")

-- move within the wrap line
vim.keymap.set("n", "k", "gk", {})
vim.keymap.set("n", "j", "gj", {})
vim.keymap.set("n", "$", "g$", {})
vim.keymap.set("n", "0", "g0", {})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

require("paq")({
	"savq/paq-nvim", -- Let Paq manage itself
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"folke/tokyonight.nvim",
	"nvim-tree/nvim-web-devicons",
	"nvim-tree/nvim-tree.lua",
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"neovim/nvim-lspconfig",
	"rafamadriz/friendly-snippets",
	"saghen/blink.cmp",
	"stevearc/conform.nvim",
	"nvim-mini/mini.nvim",
})

-- Colorscheme
vim.cmd([[colorscheme tokyonight]])

-- Treesitter
require("nvim-treesitter").setup({
	ensure_installed = { "bash", "c", "cpp", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
	-- Autoinstall languages that are not installed
	auto_install = true,
	highlight = {
		enable = true,
		-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
		--  If you are experiencing weird indenting issues, add the language to
		--  the list of additional_vim_regex_highlighting and disabled languages for indent.
		additional_vim_regex_highlighting = { "ruby" },
	},
	indent = { enable = true, disable = { "ruby" } },
})

-- nvim-tree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
require("nvim-tree").setup()

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "[F]ind Buffer" })

-- LSP
-- vim.keymap.del("n", "grn")
-- vim.keymap.del("n", "gra")
-- vim.keymap.del("n", "grr")
-- vim.keymap.del("n", "gri")
-- vim.keymap.del("n", "gO")

local lsp_normal_mappings = {
	{ key = "gK", cmd = vim.lsp.buf.hover, desc = "Show hover" },
	{ key = "gd", cmd = vim.lsp.buf.definition, desc = "Go to Definition" },
	{ key = "gD", cmd = vim.lsp.buf.declaration, desc = "Go to Declaration" },
	{ key = "gr", cmd = vim.lsp.buf.references, desc = "Go to References" },
	{ key = "gI", cmd = vim.lsp.buf.implementation, desc = "Go to Implementation" },
	{ key = "se", cmd = vim.diagnostic.open_float, desc = "Show diagnostic [E]rror messages" },
}

for _, map in ipairs(lsp_normal_mappings) do
	vim.keymap.set("n", map.key, map.cmd, { desc = map.desc })
end

-- servers
local lspservers = { "gopls", "clangd", "lua_ls" }

-- lua nvim
vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = true,
				library = {
					vim.env.VIMRUNTIME,
					"/Users/mac/Work/Project/clickhouse/Code/slr",
					-- Depending on the usage, you might want to add additional paths
					-- here.
					-- '${3rd}/luv/library'
					-- '${3rd}/busted/library'
				},
				-- Or pull in all of 'runtimepath'.
				-- NOTE: this is a lot slower and will cause issues when working on
				-- your own configuration.
				-- See https://github.com/neovim/nvim-lspconfig/issues/3189
				-- library = {
				--   vim.api.nvim_get_runtime_file('', true),
				-- }
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

for _, server in ipairs(lspservers) do
	vim.lsp.enable(server)
end

require("blink.cmp").setup({
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	keymap = {
		preset = "enter",
		["<Tab>"] = {
			function(cmp)
				if cmp.snippet_active() then
					return cmp.accept()
				else
					return cmp.select_and_accept()
				end
			end,
			"snippet_forward",
			"fallback",
		},
	},
	fuzzy = { implementation = "lua" },
})

-- format
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofmt" },
		c = { "clang-format" },
	},
})

-- format when write
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

require("mini.tabline").setup()
require("mini.statusline").setup()
