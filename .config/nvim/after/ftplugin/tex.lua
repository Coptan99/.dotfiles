local M = {}

local map = vim.keymap.set
local opts = { noremap = true, buffer = 0 }

vim.cmd("compiler tex")

-- Functions
function M.compile()
  vim.cmd('w')
  vim.cmd('cd %:p:h')
  vim.cmd('silent make')
  vim.cmd('cd -')
  vim.cmd('cwindow')
end

function M.open_pdf()
	local opta = '--synctex-forward '
	local optb = vim.fn.line(".") .. ":" .. vim.fn.col(".") .. ":" .. '%:p'
	local optc = '-c ~/.config/zathura/synctex '
	vim.cmd("silent !zathura %:p:r.pdf " .. optc .. opta .. optb .. " & disown")
end

map("n", ".c", function()
  M.compile()
end, opts)

map("n", ".r", function()
  M.open_pdf()
end, opts)

map("n", ".s", ":so /home/omar/.config/nvim/after/ftplugin/tex.lua<cr>", opts)

return M
