local opt = vim.opt

-- general
opt.clipboard = "unnamedplus"
opt.hidden = true
opt.wrap = false
opt.updatetime = 50

-- line numbers
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- appearance
opt.colorcolumn = "80"
opt.cursorline = true
opt.termguicolors = true
opt.guicursor = ""

-- indentation
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.expandtab = true
opt.smartindent = true

-- searching
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- split
opt.splitbelow = true
opt.splitright = true

-- swap files
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
