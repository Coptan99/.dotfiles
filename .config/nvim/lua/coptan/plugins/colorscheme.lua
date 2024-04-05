return {
    {
        "catppuccin/nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("catppuccin").setup({
                color_overrides = {
                    mocha = {
                        base = "#000000",
                        mantle = "#000000",
                        crust = "#000000",
                    },
                }
            })
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
    }
}
