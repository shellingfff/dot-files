
require("config.options")
require("config.lazy")
require("config.keymap")
require("config.lsp")

-- Colorscheme
vim.cmd([[colorscheme tokyonight]])

-- Treesitter
require'nvim-treesitter.configs'.setup({
	ensure_installed = { "bash", "c", "cpp", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc", "go", "rust" },
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
require("nvim-tree").setup()


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
		rust = { "rustfmt" },
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
