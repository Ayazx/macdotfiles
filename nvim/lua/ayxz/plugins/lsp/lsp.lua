return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		-- require("lspconfig").lua-ls.setup { capabilities = capabilities }
		-- Mason setup
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
			},
			automatic_installation = true,
		})

		-- local on_attach = config.on_attach
		-- local capabilities = config.capabilities

		local lspconfig = require("lspconfig")

		-- Default handler for all servers
		local servers = {
			"lua_ls",
			"pyright",
			"gopls",
			"ts_ls",
			"jdtls",
			"rust_analyzer",
			"clangd",
		}
		-- lspconfig.pyright.setup({
		--     on_attach = on_attach,
		--     capabilities = capabilities,
		--     filetypes = {"python"},
		-- })

		for _, server in ipairs(servers) do
			lspconfig[server].setup({})
		end

		-- Special setup for Lua
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
}
