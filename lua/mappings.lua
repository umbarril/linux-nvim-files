-- Use ':verbose map <mapping>' to see the history of a certain mapping and 

local map = function (original, new)
    vim.keymap.set("", original, new)
end
local vmap = function (original, new)
    vim.keymap.set("v", original, new)
end
local imap = function (original, new)
    vim.keymap.set("i", original, new)
end
local omap = function (original, new)
    vim.keymap.set("o", original, new)
end
local nmap = function (original, new)
    vim.keymap.set("n", original, new)
end

vim.cmd [[
    xnoremap <expr> <S-Tab> mode() ==# "V" ? "<gv" : "<Tab>"
    xnoremap <expr> <Tab> mode() ==# "V" ? ">gv"  : "<Tab>"
]]

-- allow using Shift+Tab in insert mode
imap("<S-Tab>", "<esc>v<li")

-- allow using Shift+Tab in normal mode
nmap("<S-Tab>", "v<")
-- allow using Tab in normal mode
-- nmap("<Tab>", "i<Tab><esc>")
nmap("<Tab>", "v>")

-- allow using Tab in visual mode
vmap("<Tab>", ">gv")
-- allow using Tab in visual mode
vmap("<S-Tab>", "<gv")

vmap('<C-c>', '"+y')
map('L', '$')
map('H', '^')

nmap("<A-o>", "o<Esc>")

-- close buffer fast
map("<leader>q", ":bp | sp | bn | bd<CR>")

-- open netrw fast
-- map("<leader>n", ":Explore<CR>")

-- Disable highlight when <leader><cr> is pressed (<leader>+Enter)
nmap("<leader><cr>", ":noh<cr>")

-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
vmap("*", ":<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>")
vmap("#", ":<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>")

-- satisfaction
-- ww.reddit.com/r/neovim/comments/rfrgq5/is_it_possible_to_do_something_like_his_on/
-- TODO: look at this plugin later https://github.com/matze/vim-move
vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")
imap("<C-j>","<esc>:m .+1<Cr>==i")
imap("<C-k>", "<esc>:m .-2<Cr>==i")

map("ç", '"_d')
map("Ç", '"_d$')
-- https://vi.stackexchange.com/questions/2543/how-can-i-map-dcountd
omap("ç", "d")

nmap("<C-\\>", "<C-]>")

-- Stop things from going to clipboard
vmap("p", '"_dP')
nmap("x", '"_x')
nmap("X", '"_X')

-- go back to the previous opened file (:h CTRL-^)
nmap("<", "<C-^>")

-- Fast saving
nmap("<leader>w", ":w!<cr>")

-- Substitute
nmap("<leader>s", ":%s//g<Left><Left>")
vmap("<leader>s", ":s//g<Left><Left>")

nmap("<leader><leader>s", ':%s/<C-R>"//g<Left><Left>')
vmap("<leader><leader>s", ":cal VisualSelection('', '')<CR>:'<,'>s/<C-R>=@/<CR>//g<Left><Left>")

-- Allow using ENTER to break lines in normal mode
nmap("<Enter>", "i<Right><CR><ESC>")

-- sets F7 to ident the whole file when pressed
map("<F7>", "gg=G<C-o>zz")

-- Allow Ctrl+v in insert mode
-- map("<C-v>", "<C-r>+", "!") doens't work
vim.cmd [[map! <C-v> <C-r>+]]

-- Allow Ctrl+c in visual mode
vmap("<C-c>", '"+y')
imap("<C-v>", "<C-R>+")

-- Smart way to move between windows
-- NOT NECESSARY SINCE BARBAR PLUGIN CONFIG ALREADY IMPLEMENTS THAT
-- nmap("<C-j>", "<C-W>j")
-- nmap("<C-k>", "<C-W>k")
-- nmap("<C-h>", "<C-W>h")
-- nmap("<C-l>", "<C-W>l")

-- Close the current buffer (already on bclose.vim)
-- look https://vim.fandom.com/wiki/Deleting_a_buffer_without_closing_the_window
-- map <leader>bd :Bclose<cr>:tabclose<cr>gT

-- Close all the buffers
map("<leader>ba", ":bufdo bd<cr>")

map("<leader>l", ":bnext<cr>")
map("<leader>h", ":bprevious<cr>")

-- Useful mappings for managing tabs
map("<leader>tn", ":tabnew<cr>")
map("<leader>to", ":tabonly<cr>")
map("<leader>tc", ":tabclose<cr>")
map("<leader>tm", ":tabmove ")
map("<leader>t<leader>", ":tabnext ")

-- Opens a new tab with the current buffer's path
-- Super useful when editing files in the same directory
map("<leader>te", ':tabedit <C-r>=expand("%:p:h")<cr>/')

-- Switch CWD to the directory of the open buffer
map("<leader>cd", ":cd %:p:h<cr>:pwd<cr>")

-- vmap("I", "<C-V>^I")
-- vmap("A", "<C-V>$A")

nmap("<leader>y", '"+y')
vmap("<leader>y", '"+y')
nmap("<leader>Y", 'gg"+y')

nmap("<leader>p", '"+p')
nmap("<leader>P", '"+P')
vmap("<leader>p", '"+p')
vmap("<leader>P", '"+P')

nmap("n", "nzzzv")
nmap("N", "nzzzv")

-- undo better
imap(",", ",<c-g>u")
imap(";", ";<c-g>u")
imap(".", ".<c-g>u")
imap("!", "!<c-g>u")
imap("?", "?<c-g>u")

-- TODO: se linha começar com - e voc6e apertar tab, a linha inteira vai para frente
-- vim.keymap.set('i', '<tab>', function ()
--
--     
-- end)
