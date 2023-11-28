local keymap = vim.keymap

keymap.set("n", "<leader>pv", ":Ex<CR>")
keymap.set({"n", "v"}, "<localleader><localleader>", ":nohl<CR>")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("x", "<leader>p", [["_dP]])
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/init.lua<CR>");

keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
