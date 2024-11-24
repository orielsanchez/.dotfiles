-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- File encoding
vim.opt.fileencoding = "utf-8"
vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax enable]])
vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
-- Enable dark background colorschemes
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.have_nerd_font = true

-- Color column 80
vim.opt.colorcolumn = "80"

-- Auto-indent new lines
vim.opt.autoindent = true
-- Enable smart-indent
vim.opt.smartindent = true

-- Use spaces instead of tabs
vim.opt.expandtab = true
-- Number of auto-indent spaces
vim.opt.shiftwidth = 4
-- Number of spaces per Tab
vim.opt.softtabstop = 4
-- Number of columns per tab
vim.opt.tabstop = 4

-- No wrap
vim.opt.wrap = false

-- ALways case-insensitive
vim.opt.ignorecase = true
-- Enable smartcase search
vim.opt.smartcase = true

-- Searches for strings incrementally
vim.opt.incsearch = true
-- No highlighting when searching
vim.opt.hlsearch = false

-- Show line numbers
vim.opt.number = true
-- Enable relative line numbers
vim.opt.relativenumber = true
vim.opt.showmode = false
-- enable mouse for normal and visual modes
vim.opt.mouse = "nv"
-- enable system-wide clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable completion for vim-compe
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Show max. 10 completions
vim.opt.pumheight = 10

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Folding configuration
vim.opt.viewoptions:remove("options")
vim.opt.foldmethod = "marker"

-- Real-time substitute
vim.opt.inccommand = "split"

-- Display eol characters
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Global statusline
vim.opt.laststatus = 3

-- Fold column
vim.opt.foldcolumn = "auto:9"
vim.opt.signcolumn = "yes"

-- Lead scroll by 8 lines
vim.opt.scrolloff = 8

-- No redraw during macro, regex execution
vim.opt.lazyredraw = true

-- No swap file
vim.opt.swapfile = false

-- Enable title
vim.opt.title = true

-- Highlight cursor row
vim.opt.cursorline = true

vim.opt.undofile = true

-- Time in milliseconds to wait for a mapped sequence to complete.
vim.opt.timeoutlen = 300

-- Maximum width of text that is being inserted.
-- vim.opt.textwidth = 80

vim.opt.updatetime = 250
vim.opt.startofline = false
