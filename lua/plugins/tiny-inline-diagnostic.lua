return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	opts = {
		options = {
			multilines = {
				enabled = true,
				always_show = true,
				severity = { vim.diagnostic.severity.ERROR },
			},
			show_related = {
				enabled = true,
				max_count = 5,
			},
			show_all_diags_on_cursorline = false,
			show_diags_only_under_cursor = false,
		},
		preset = "classic",
	},
	init = function()
		vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
	end,
}
