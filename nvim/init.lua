-- ============================================================
-- Basic globals
-- ============================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

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


vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/jghauser/follow-md-links.nvim" },
})

-- ============================================================
-- Keymaps
-- ============================================================

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {
    desc = "Move focus to the left window",
})
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {
    desc = "Move focus to the right window",
})
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {
    desc = "Move focus to the lower window",
})
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {
    desc = "Move focus to the upper window",
})

vim.keymap.set("n", "H", "<cmd>bp<CR>")
vim.keymap.set("n", "L", "<cmd>bn<CR>")
vim.keymap.set("n", "gh", "<cmd>normal! H<CR>")
vim.keymap.set("n", "gl", "<cmd>normal! L<CR>")

vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "$", "g$")
vim.keymap.set("n", "0", "g0")

local pick = require("mini.pick")

-- <leader>ff：搜索文件
vim.keymap.set("n", "<leader>ff", function()
pick.builtin.files()
end, {
desc = "MiniPick find files",
})

-- <leader>fg：实时全文搜索
vim.keymap.set("n", "<leader>fg", function()
pick.builtin.grep_live()
end, {
desc = "MiniPick live grep",
})

-- <leader>fb：搜索已打开的 buffer
vim.keymap.set("n", "<leader>fb", function()
pick.builtin.buffers()
end, {
desc = "MiniPick buffers",
})

-- ============================================================
-- Colorscheme
-- ============================================================

vim.cmd.colorscheme("tokyonight")

-- ============================================================
-- Treesitter
-- ============================================================

require("nvim-treesitter").setup({})

local parsers = {
    --"bash",
    --"c",
    --"cpp",
    --"diff",
    --"html",
    --"lua",
    --"luadoc",
    "markdown",
    --"vim",
    --"vimdoc",
    --"go",
}

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        --"bash",
        --"c",
        --"cpp",
        --"diff",
        --"html",
        --"lua",
        "markdown",
        --"vim",
        --"vimdoc",
        --"go",
    },
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- ============================================================
-- mini.nvim
-- ============================================================

require("mini.tabline").setup()
require("mini.statusline").setup()
require("mini.diff").setup()
require("mini.pick").setup()

-- ============================================================
-- Follow Markdown links
-- ============================================================

--require("follow-md-links").setup({
--    browsers = { "firefox", "chromium" },
--})

-- ============================================================
-- Autocmds
-- ============================================================

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup(
        "kickstart-highlight-yank",
        { clear = true }
    ),
    callback = function()
        vim.highlight.on_yank()
    end,
})
