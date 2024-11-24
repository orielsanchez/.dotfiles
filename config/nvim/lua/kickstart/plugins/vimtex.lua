return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "sioyek"
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_mappings_enabled = 1
		vim.g.vimtex_indent_enabled = 0
		vim.g.tex_flavor = "latex"
		vim.g.tex_indent_items = 0
		vim.g.tex_indent_brace = 0
		vim.g.vimtex_format_enabled = 1
		vim.g.vimtex_context_pdf_viewer = "sioyek"
		vim.g.vimtex_log_ignore = {
			"Underfull",
			"Overfull",
			"specifier changed to",
			"Token not allowed in a PDF string",
		}
	end,
}
