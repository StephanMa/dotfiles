local prompt = [[
          ___           ___                       ___           ___
         /\__\         /|  |                     /\  \         /\__\
        /:/ _/_       |:|  |          ___        \:\  \       /:/ _/_         ___
       /:/ /\  \      |:|  |         /|  |        \:\  \     /:/ /\__\       /\__\
      /:/ /::\  \   __|:|  |        |:|  |    _____\:\  \   /:/ /:/ _/_     /:/  /
     /:/_/:/\:\__\ /\ |:|__|____    |:|  |   /::::::::\__\ /:/_/:/ /\__\   /:/__/
     \:\/:/ /:/  / \:\/:::::/__/  __|:|__|   \:\~~\~~\/__/ \:\/:/ /:/  /  /::\  \
      \::/ /:/  /   \::/~~/~     /::::\  \    \:\  \        \::/_/:/  /  /:/\:\  \
       \/_/:/  /     \:\~~\      ~~~~\:\  \    \:\  \        \:\/:/  /   \/__\:\  \
         /:/  /       \:\__\          \:\__\    \:\__\        \::/  /         \:\__\
         \/__/         \/__/           \/__/     \/__/         \/__/           \/__/
]]

return {
	"jackMort/ChatGPT.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun" },
	cond = function()
		if not os.getenv("OPENAI_API_KEY") then
			print("Please set the environment variable OPENAI_API_KEY to your OpenAI API key to enable ChatGPT")
			return false
		end
		if not os.getenv("HOME") then
			print("Please set the environment variable HOME to your home directory to enable ChatGPT")
			return false
		end
		return true
	end,
	config = function()
		local style = "single"
		require("chatgpt").setup({
			chat = {
				welcome_message = prompt,
				question_sign = "󱍊",
				answer_sign = "",
				loading_text = "processing inquiry",
				sessions_window = {
					border = {
						style = style,
					},
				},
			},
			popup_window = {
				border = {
					style = style,
					text = {
						top = " Digital Inquiry Interface ",
					},
				},
			},
			system_window = {
				border = {
					style = style,
				},
			},
			popup_input = {
				prompt = "",
				border = {
					style = style,
					text = {
						top = " Enter Inquiry Sequence ",
					},
				},
				submit = "<Enter>",
			},
			settings_window = {
				border = {
					style = style,
				},
			},
			openai_params = {
				-- https://platform.openai.com/docs/models
				-- text-davinci-003 ; text-curie-001 ; text-babbage-001 ; text-ada-001 ; gpt-3.5-turbo
				model = "gpt-3.5-turbo",
				max_tokens = 1000,
			},
			openai_edit_params = {
				-- https://platform.openai.com/docs/guides/code/editing-code
				model = "code-davinci-edit-001",
			},
			show_quickfixes_cmd = "quickfix",
		})
		local transparent = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
		vim.api.nvim_set_hl(0, "ChatGPTTotalTokens", { link = "Comment" })
		vim.api.nvim_set_hl(0, "ChatGPTTotalTokensBorder", { bg = transparent, fg = transparent })
		vim.api.nvim_set_hl(0, "ChatGPTMessageAction", { link = "CursorIM" })
		vim.api.nvim_set_hl(0, "ChatGPTQustion", { link = "ChatGPTQuestion" }) -- @see https://github.com/jackMort/ChatGPT.nvim/pull/274
	end,
}
