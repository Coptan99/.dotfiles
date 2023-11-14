return {
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("dracula").setup({

			})
			require("dracula").load()
		end,
	}
}

