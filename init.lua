-- para mais informaçÕes, faça :help lua-guide

-- para o neovide
vim.o.guifont="JetBrainsMono NF:h16"

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- MOVER ISSO PARA O ARQUIVO CORRETO!! TODO:
-- Cria todos os diretorios necessarios para que voce consiga salvar o ARQUIVO
-- Exemplo: salvar .config/tmux/tmux.conf sendo que .config/tmux nao existe ainda
vim.cmd [[
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
]]

require('options')
require('autocmds')
require('mappings')

require('lazy').setup (
    {
        { import = "plugins" }
    },
    {
        install = {
            colorscheme = {"nightfly"}
        },
        checker = {
            enabled = true,
            notify = false,
        },
        change_detection = {
            notify = true
        }
    }
)

