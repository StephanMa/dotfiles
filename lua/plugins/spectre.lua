return {
  'nvim-pack/nvim-spectre',
  event = "InsertEnter",
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  
	config = function()
		require("spectre").setup()
	end,
}
