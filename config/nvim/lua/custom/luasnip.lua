local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmta = require("luasnip.extras.fmt").fmta
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

ls.setup({
	region_check_events = "InsertEnter",
})

ls.config.set_config({
	-- Don't store snippet history for less overhead
	history = false,
	-- Allow autotrigger snippets
	enable_autosnippets = true,
	-- For equivalent of UltiSnips visual selection
	store_selection_keys = "<Tab>",
	-- Event on which to check for exiting a snippet's region
	region_check_events = "InsertEnter",
	delete_check_events = "InsertLeave",
})
require("luasnip.loaders.from_lua").load({
	paths = { "./snippets" },
	fs_event_providers = { libuv = true },
})
ls.filetype_extend("tex", { "cpp", "python" })
vim.cmd([[silent command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()]])

vim.keymap.set({ "i" }, "<C-K>", function()
	ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
	ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })
