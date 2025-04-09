-- Search and replace in project
return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		-- Open spectre
		{
			"<leader>sR",
			function()
				require("spectre").toggle()
			end,
			desc = "Search and replace in project",
		},
	},
}
