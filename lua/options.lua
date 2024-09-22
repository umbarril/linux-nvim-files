local opt = vim.opt

-- leader key NEEDS be defined before any plugin tries to use it
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- vim.cmd [[ colorscheme habamax ]]
vim.cmd [[
  highlight Error guibg=red
  highlight link Warning Error
]]

-- HOW DID I LIVE WITHOUT THIS BEFORE???? 
-- this lets you move to one more character after the end
-- be sure this doesn't break any plugins you already have before adding this
opt.virtualedit:append("onemore")

-- lets you move where there is no chracter in visual block mode
opt.virtualedit:append("block")

-- Set to auto read when a file is changed from the outside
opt.autoread = true

---- see which is better
-- opt.signcolumn = 'yes' 
opt.signcolumn = 'number'

opt.wildignore = { '*.o', '*.a', '__pycache__' }
opt.listchars = { space = '_', tab = '>~' }

opt.colorcolumn = '80'
-- opt.list = true -- add dots to whitespaces to make it more legible
opt.wrap = false
opt.lbr = false
-- set.linebreak  = true		-- Break lines at word (requires Wrap lines)
-- set.showbreak = '+++'            -- Wrap-broken line prefix

-- Use visual bell (no beeping)
opt.visualbell = true

-- Lets me use the mouse just like any other text editor
opt.mouse = 'a'
opt.history = 500

-- Ignore compiled files
opt.wildignore = "__pycache__"
opt.wildignore:append { "*.o", "*~", "*.pyc", "*pycache*" }
opt.wildignore:append "Cargo.lock"
opt.wildignore:append "**/.git/"
opt.wildignore:append "*_build/"
opt.wildignore:append "**/node_modules/"

opt.showcmd = true
opt.cmdheight = 1 -- Height of the command bar
opt.incsearch = true -- Makes search act like search in modern browsers
opt.showmatch = true -- show matching brackets when text indicator is over them
opt.relativenumber = true -- Show line numbers
opt.number = true -- But show the actual number for the line we're on
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.hidden = true -- I like having buffers stay around
opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor
opt.expandtab = true
opt.shiftround = true
opt.smartindent = true
opt.termguicolors = true

-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

opt.foldmethod = "expr"
opt.foldlevel = 100
opt.modelines = 1

opt.undofile = true
opt.undolevels = 1000
