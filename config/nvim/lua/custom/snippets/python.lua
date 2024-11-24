require("luasnip.session.snippet_collection").clear_snippets("all")
local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix
local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local f = ls.function_node
local sn = ls.snippet_node
local d = ls.dynamic_node
local r = ls.restore_node

ls.add_snippets("lua", {})
