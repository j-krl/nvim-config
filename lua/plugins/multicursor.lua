return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")

		mc.setup()

		local set = vim.keymap.set

		-- Add or skip cursor above/below the main cursor.
		set({ "n", "v" }, "<C-c>k", function()
			mc.lineAddCursor(-1)
		end, { desc = "Add cursor above" })
		set({ "n", "v" }, "<C-c>j", function()
			mc.lineAddCursor(1)
		end, { desc = "Add cursor below" })
		set({ "n", "v" }, "<C-c>K", function()
			mc.lineSkipCursor(-1)
		end, { desc = "Skip cursor above" })
		set({ "n", "v" }, "<C-c>J", function()
			mc.lineSkipCursor(1)
		end, { desc = "Skip cursor below" })

		-- Add or skip adding a new cursor by matching word/selection
		set({ "n", "v" }, "<C-c>n", function()
			mc.matchAddCursor(1)
		end, { desc = "Add cursor by match below" })
		set({ "n", "v" }, "<C-c>s", function()
			mc.matchSkipCursor(1)
		end, { desc = "Skip cursor by match below" })
		set({ "n", "v" }, "<C-c>N", function()
			mc.matchAddCursor(-1)
		end, { desc = "Add cursor by match above" })
		set({ "n", "v" }, "<C-c>S", function()
			mc.matchSkipCursor(-1)
		end, { desc = "Skip cursor by match above" })

		-- Add all matches in the document
		set({ "n", "v" }, "<C-c>A", mc.matchAllAddCursors, { desc = "Add cursor add all matches" })

		-- Rotate the main cursor.
		set({ "n", "v" }, "<C-c>r", mc.nextCursor, { desc = "Move cursor next" })
		set({ "n", "v" }, "<C-c>R", mc.prevCursor, { desc = "Move cursor prev" })

		-- Delete the main cursor.
		set({ "n", "v" }, "<C-c>d", mc.deleteCursor, { desc = "Delete cursor" })

		-- Add and remove cursors with control + right click.
		set("n", "<C-rightmouse>", mc.handleMouse, { desc = "Add cursor on click" })

		-- Easy way to add and remove cursors using the main cursor.
		set({ "n", "v" }, "<C-c>c", mc.toggleCursor, { desc = "Add cursor under main cursor" })

		set("n", "<esc>", function()
			if not mc.cursorsEnabled() then
				mc.enableCursors()
			elseif mc.hasCursors() then
				mc.clearCursors()
			else
				-- Default <esc> handler.
			end
		end)

		-- bring back cursors if you accidentally clear them
		set("n", "<C-c>u", mc.restoreCursors, { desc = "Restore cursors" })

		-- Split visual selections by regex.
		set("v", "<C-c>x", mc.splitCursors, { desc = "Split visual selections by regex" })

		-- Append/insert for each line of visual selections.
		set("v", "I", mc.insertVisual, { desc = "Prepend at each line of visual selection" })
		set("v", "A", mc.appendVisual, { desc = "Append each line of visual selection" })

		-- match new cursors within visual selections by regex.
		set("v", "<C-c>X", mc.matchCursors, { desc = "Match within visual selections" })

		-- Customize how cursors look.
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { link = "Cursor" })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
