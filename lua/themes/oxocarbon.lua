return {
	"nyoom-engineering/oxocarbon.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local function fix_blink_highlights()
			-- oxocarbon ships badge-style blink.cmp highlights (icon drawn in the
			-- menu background color on a colored chip) and disables the selection
			-- background; flip the accent color into the foreground and restore
			-- the selection highlight.
			local kinds = {
				"Text",
				"Method",
				"Function",
				"Constructor",
				"Field",
				"Variable",
				"Property",
				"Class",
				"Interface",
				"Struct",
				"Module",
				"Unit",
				"Value",
				"Enum",
				"EnumMember",
				"Keyword",
				"Constant",
				"Snippet",
				"Color",
				"File",
				"Reference",
				"Folder",
				"Event",
				"Operator",
				"TypeParameter",
			}
			for _, kind in ipairs(kinds) do
				local name = "BlinkCmpKind" .. kind
				if vim.fn.hlexists(name) == 1 then
					local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
					if hl.bg then
						vim.api.nvim_set_hl(0, name, { fg = hl.bg, bg = "none" })
					end
				end
			end
			vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })
		end

		vim.cmd.colorscheme("oxocarbon")
		fix_blink_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "oxocarbon",
			callback = fix_blink_highlights,
		})
	end,
}
