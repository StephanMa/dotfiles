return {
	"zbirenbaum/copilot-cmp",
	event = "InsertEnter",
	dependencies = {
		"zbirenbaum/copilot.lua",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("copilot_cmp").setup({
			method = "getCompletionsCycling",
		})
	end,
}


