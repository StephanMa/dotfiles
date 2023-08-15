
return {
	"sbdchd/neoformat",
	event = "BufReadPre",
	config = function()
		vim.g.neoformat_run_all_formatters = 1

		-- Custom formatter definitions
		vim.g.neoformat_python_my_isort_black = {
			exe = "isort",
			args = { "--profile", "black", "-", "--quiet" },
			stdin = 1,
		}
		vim.g.neoformat_php_my_phpcsfixer = {
			exe = "php-cs-fixer",
			args = { "fix", "-q", "--rules=@Symfony,-@PSR12" },
			replace = 1,
		}

		-- Manually specify some languages to avoid conflicts
		vim.g.neoformat_enabled_javascript = { "prettierd" }
		vim.g.neoformat_enabled_javascriptreact = { "prettierd" }
		vim.g.neoformat_enabled_typescript = { "prettierd" }
		vim.g.neoformat_enabled_typescriptreact = { "prettierd" }
		vim.g.neoformat_enabled_python = { "black", "my_isort_black" }

		local fmt_group_id = vim.api.nvim_create_augroup("fmt", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			group = fmt_group_id,
			callback = function()
				vim.cmd("Neoformat")
			end,
		})
	end,
}

