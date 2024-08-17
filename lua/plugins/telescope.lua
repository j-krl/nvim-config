return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			version = "^1.0.0",
		},
	},
	config = function()
		local telescope = require("telescope")
		local sorters = require("telescope.sorters")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				mappings = {
					n = {
						["<C-Q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
				vimgrep_arguments = {
					-- All default args without smart-case
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
			},
			pickers = {
				buffers = {
					sort_mru = true,
				},
				lsp_dynamic_workspace_symbols = {
					-- https://github.com/nvim-telescope/telescope.nvim/issues/2104
					sorter = sorters.get_fzy_sorter(),
				},
			},
			extensions = {
				live_grep_args = {
					mappings = {
						i = {
							["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
						},
					},
				},
			},
		})
		telescope.load_extension("live_grep_args")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({
				hidden = true,
				find_command = { "fd", "--type", "f", "--color", "never", "--no-ignore-vcs" },
			})
		end, {})
		vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>fc", function()
			builtin.colorscheme({ enable_preview = true })
		end, {})
		vim.keymap.set("n", "<leader>fs", function()
			builtin.lsp_dynamic_workspace_symbols({ ignore_symbols = { "variable" } })
		end, {})
	end,
}
