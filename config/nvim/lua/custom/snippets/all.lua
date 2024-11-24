require("luasnip.session.snippet_collection").clear_snippets("all")
-- local helpers = require("custom.luasnip-helper-funcs")
-- local get_visual = helpers.get_visual
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("all", {
	s("hi", t("hello world")),
})
