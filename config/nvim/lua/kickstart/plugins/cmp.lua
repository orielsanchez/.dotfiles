return {
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"micangl/cmp-vimtex",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local ls = require("luasnip")
			require("custom.plugins")
			ls.config.setup({})

			for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
				loadfile(ft_path)()
			end

			require("cmp_vimtex").setup({
				additional_information = {
					info_in_menu = true,
					info_in_window = true,
					info_max_length = 60,
					match_against_info = true,
					symbols_in_menu = true,
				},
				bibtex_parser = {
					enabled = true,
				},
				search = {
					browser = "xdg-open",
					default = "google_scholar",
					search_engines = {
						google_scholar = {
							name = "Google Scholar",
							get_url = require("cmp_vimtex").url_default_format(
								"https://scholar.google.com/scholar?hl=en&q=%s"
							),
						},
					},
				},
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),

					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<Enter>"] = cmp.mapping.confirm({ select = true }),
					["<C-Enter>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete({}),

					["<C-l>"] = cmp.mapping(function()
						if ls.expand_or_locally_jumpable() then
							ls.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if ls.locally_jumpable(-1) then
							ls.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{
						name = "lazydev",
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "vimtex" },
				},
			})
		end,
	},
}
-- vim : ts=2 sts=2 sw=2 et
