vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function() vim.highlight.on_yank() end
})

local mygroup = vim.api.nvim_create_augroup('vimrc', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.html',
  group = mygroup,
  command = 'set shiftwidth=4',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.html',
  group = 'vimrc',  -- equivalent to group=mygroup
  command = 'set expandtab',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = 'MAKEFILE',
  command = 'set noexpandtab',
})

vim.cmd [[
    " stop vim to autocomment when pressing o/O or Enter
    augroup NoAutoComment
    au!
    au FileType * setlocal formatoptions-=cr
    " read more in :h 'formatoptions'
    augroup end

    au TabLeave * let g:lasttab = tabpagenr()

    " copied from https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/init.vim
    " and https://www.youtube.com/watch?v=n9k9scbTuvQ
    " Return to last edit position when opening files (You want this!)
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    augroup highlight_yank
        autocmd!
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
    augroup END

    autocmd VimResized * wincmd =

    " copied from https://github.com/nickjj/dotfiles/blob/19397b0f4cdd98feb38f94612851235b8f0d883e/.vimrc#L376-L380
    autocmd BufNewFile,BufRead requirements*.txt set ft=python
    autocmd BufNewFile,BufRead .*aliases set ft=sh

    " Ensure tabs don't get converted to spaces in Makefiles.
    autocmd FileType make setlocal noexpandtab

    autocmd BufWinLeave *.* mkview
    autocmd BufWinLeave *.* silent loadview

    " automatically format everytime you save the file
    " autocmd BufWritePost * exe "normal! gg=G\<C-o>zz"

    " change scroll offset
    autocmd VimResized,VimEnter,WinEnter * let &scrolloff = winheight(0) / 6

    au FocusGained,BufEnter * checktime

    highlight ColorColmn ctermbg=0 guibg=lightgrey
    function! VisualSelection(direction, extra_filter) range
        let l:saved_reg = @"
        execute "normal! vgvy"

        let l:pattern = escape(@", "\\/.*'$^~[]")
        let l:pattern = substitute(l:pattern, "\n$", "", "")

        if a:direction == 'gv'
            call CmdLine("Ack '" . l:pattern . "' " )
        elseif a:direction == 'replace'
            call CmdLine("%s" . '/'. l:pattern . '/')
        endif

        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction

    " make gx work on packge.json (https://doriankarter.com/customize-vims-gx-mapping/)
    function! PackageJsonGx() abort
        let l:line = getline('.')
        let l:package = matchlist(l:line, '\v"(.*)": "(.*)"')

        if len(l:package) > 0
            let l:package_name = l:package[1]
            let l:url = 'https://www.npmjs.com/package/' . l:package_name
            call netrw#BrowseX(l:url, 0)
        endif
    endfunction

    augroup PackageJsonGx
        autocmd!
        autocmd BufRead,BufNewFile package.json nnoremap <buffer> <silent> gx :call PackageJsonGx()<cr>
    augroup END

    " make gx work in plug manager (https://doriankarter.com/customize-vims-gx-mapping/)
    function! PlugGx()
        let l:line = getline('.')
        let l:sha  = matchstr(l:line, '^  \X*\zs\x\{7,9}\ze ')

        if (&filetype ==# 'vim-plug')
            " inside vim plug splits such as :PlugStatus
            let l:name = empty(l:sha)
                        \ ? matchstr(l:line, '^[-x+] \zs[^:]\+\ze:')
                        \ : getline(search('^- .*:$', 'bn'))[2:-2]
        else
            " in .vimrc.bundles
            let l:name = matchlist(l:line, '\v/([A-Za-z0-9\-_\.]+)')[1]
        endif

        let l:uri  = get(get(g:plugs, l:name, {}), 'uri', '')
        if l:uri !~? 'github.com'
            return
        endif
        let l:repo = matchstr(l:uri, '[^:/]*/'.l:name)
        let l:url  = empty(l:sha)
                    \ ? 'https://github.com/'.l:repo
                    \ : printf('https://github.com/%s/commit/%s', l:repo, l:sha)
        call netrw#BrowseX(l:url, 0)
    endfunction

    augroup PlugGxGroup
        autocmd!
        autocmd BufRead,BufNewFile plugins.lua nnoremap <buffer> <silent> gx :call PlugGx()<cr>
        autocmd FileType vim-plug nnoremap <buffer> <silent> gx :call PlugGx()<cr>
    augroup END

    " TODO: make gx work on obsidian.md markdown files
    function! ObsidianMD() abort
        let l:line = getline('.')
        let [line, column] = getpos('.')
        let l:package = matchlist(l:line, '\v"(.*)": "(.*)"')

        if len(l:package) > 0
            call netrw#BrowseX(l:url, 0)
        endif
    endfunction

    " a way of making folds look better
    " stolen from https://github.com/nvim-treesitter/nvim-treesitter/pull/390
    function! GetSpaces(foldLevel)
        if &expandtab == 1
            Indenting with spaces
            let str = repeat(" ", a:foldLevel / (&shiftwidth + 1) - 1)
            return str
        elseif &expandtab == 0
            " Indenting with tabs
            return repeat(" ", indent(v:foldstart) - (indent(v:foldstart) / &shiftwidth))
        endif
    endfunction

    function! MyFoldText()
        let startLineText = getline(v:foldstart)
        let endLineText = trim(getline(v:foldend))
        let indentation = GetSpaces(foldlevel("."))
        let spaces = repeat(" ", 200)

        let str = indentation . startLineText . "..." . endLineText . spaces

        return str
    endfunction

    " Custom display for text when folding
    set foldtext=MyFoldText()
]]
