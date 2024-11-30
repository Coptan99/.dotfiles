return {
	{
		"j-hui/fidget.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("fidget").setup({
				notification = {
					window = {
						winblend = 0,
					},
				},
			})
		end,
	},
}
