-- [[ Basic Keymaps ]]
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "yie", "ggyG<C-o>", { desc = "Copy all" })
vim.keymap.set("n", "die", "ggdG<C-o>", { desc = "Delete all" })
vim.keymap.set("n", "<leader>ccb", "<CMD>bd<CR>", { desc = "[C]lose [C]urrent [B]uffer" })
vim.keymap.set("n", "<leader>date", 'i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>')
-- vim.keymap.set("i", "<leader>date", '<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>')
-- Disable automatic comment wrapping and insertion of comment leaders
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
	end,
})

local usercommand = vim.api.nvim_create_user_command
usercommand("WQ", "wq", {})
usercommand("Wq", "wq", {})
usercommand("W", "w", {})
usercommand("Qa", "qa", {})
usercommand("Q", "q", {})

-- vim: ts=2 sts=2 sw=2 et
