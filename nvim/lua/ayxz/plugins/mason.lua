return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"gopls",
				"ts_ls",
				"jdtls",
				"rust_analyzer",
				"clangd",
				-- "codelldb",
			},
			automatic_installation = true,
		})
	end,
}
