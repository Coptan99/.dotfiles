vim.g.mapleader = " "
vim.g.maplocalleader = "."

require("coptan.config.options")
require("coptan.config.keymaps")

-- bootstrapping lazy
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    }
end
vim.opt.runtimepath:prepend(lazypath)

-- installing lazy
require("lazy").setup({ { import = "coptan.plugins" }, { import = "coptan.plugins.lsp" } } , {
    dev = {
        -- directory where you store your local plugin projects
        path = "~/projects/plugins",
        fallback = false,
    },
    install = {
        colorscheme = { "gruvbox" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
})

local augroup = vim.api.nvim_create_augroup
local CoptanGroup = augroup('Coptan', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = CoptanGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
