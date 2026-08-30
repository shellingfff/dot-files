-- ============================================================
-- Basic globals
-- ============================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- nvim-tree requires disabling netrw early
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================================
-- Basic options
-- ============================================================

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.fileencodings = { "utf-8" }
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.inccommand = "split"
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.termguicolors = true

-- ============================================================
-- Bootstrap lazy.nvim
-- ============================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local choice = vim.fn.confirm(
		"lazy.nvim is not installed. Clone it now?",
		"&Clone\n&Exit",
		1
	)

	if choice ~= 1 then
		vim.api.nvim_echo({
			{ "lazy.nvim is required but not installed. Exiting...", "ErrorMsg" },
		}, true, {})
		os.exit(1)
	end

	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- Plugins
-- ============================================================

require("lazy").setup({
	spec = {
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
		},
		"folke/tokyonight.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-tree/nvim-tree.lua",
		{
			"nvim-telescope/telescope.nvim",
			version = "*",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			},
		},
		"neovim/nvim-lspconfig",
		-- "rafamadriz/friendly-snippets",
		-- "saghen/blink.cmp",
		"stevearc/conform.nvim",
		"nvim-mini/mini.nvim",
		"davidgranstrom/nvim-markdown-preview",
                {
                    "shellingfff/follow-md-links.nvim",
                    opts = {
                        browsers = { "firefox", "chromium" },
                    }
                }
	},
})

-- ============================================================
-- Keymaps
-- ============================================================

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "H", "<cmd>bp<CR>")
vim.keymap.set("n", "L", "<cmd>bn<CR>")
vim.keymap.set("n", "gh", "<cmd>normal!H<CR>")
vim.keymap.set("n", "gl", "<cmd>normal!L<CR>")

vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "$", "g$")
vim.keymap.set("n", "0", "g0")

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
vim.keymap.set({ "n", "v" }, "<leader>fm", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

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
	{ key = "gI", cmd = vim.lsp.buf.implementation, desc = "Go to Implementation" },
	{ key = "se", cmd = vim.diagnostic.open_float, desc = "Show diagnostic [E]rror messages" },
}

for _, map in ipairs(lsp_normal_mappings) do
	vim.keymap.set("n", map.key, map.cmd, { desc = map.desc })
end

-- ============================================================
-- Colorscheme
-- ============================================================

vim.cmd.colorscheme("tokyonight")

-- ============================================================
-- Plugin setup
-- ============================================================

require("nvim-treesitter").setup({
	ensure_installed = { "bash", "c", "cpp", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc", "go" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "ruby" },
	},
	indent = { enable = true, disable = { "ruby" } },
})

require("nvim-tree").setup()

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofmt" },
		c = { "clang-format" },
	},
})

-- require("blink.cmp").setup({
-- 	sources = {
-- 		default = { "lsp", "path", "snippets", "buffer" },
-- 	},
-- 	keymap = {
-- 		preset = "enter",
-- 		["<Tab>"] = {
-- 			function(cmp)
-- 				if cmp.snippet_active() then
-- 					return cmp.accept()
-- 				else
-- 					return cmp.select_and_accept()
-- 				end
-- 			end,
-- 			"snippet_forward",
-- 			"fallback",
-- 		},
-- 	},
-- 	fuzzy = { implementation = "lua" },
-- })

require("mini.tabline").setup()
require("mini.statusline").setup()
require("mini.diff").setup()

-- ============================================================
-- LSP
-- ============================================================

local lspservers = { "gopls", "clangd", "lua_ls" }

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			workspace = {
				checkThirdParty = true,
				library = {
					vim.env.VIMRUNTIME,
				},
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

-- ============================================================
-- Autocmds
-- ============================================================

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})


