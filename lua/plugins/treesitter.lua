return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "vim", "vimdoc", "html", "css", "typescript", "javascript", "python" },
			auto_install = true,
			highlight = {
				enable = true,
				use_languagetree = true,
			},
			indent = { enable = true },
		})
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldtext = ""
		vim.wo.foldmethod = "expr"
		vim.opt.foldlevel = 99
		vim.opt.foldcolumn = "0"
	end,
}
