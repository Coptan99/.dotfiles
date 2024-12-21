return {
	"stevearc/oil.nvim",
	opts = {},
	config = function()
		require("oil").setup({
		default_file_explorer = false
	})
	end,
}
