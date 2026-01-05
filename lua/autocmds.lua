
---- AUTOCMDS ----

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
    group = mygroup,
    command = 'set expandtab',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = 'MAKEFILE',
    command = 'set noexpandtab',
})

vim.api.nvim_create_augroup("NoAutoComment", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
      group = "NoAutoComment",
      pattern = "*",
      callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r" })
      end,
})

vim.api.nvim_create_autocmd("TabLeave", {
      pattern = "*",
      callback = function()
        vim.g.lasttab = vim.fn.tabpagenr()
      end,
})

-- converted to lua from https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/init.vim
-- and https://www.youtube.com/watch?v=n9k9scbTuvQ
-- Return to last edit position when opening files (You want this!)
vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = "*",
      callback = function()
        local line = vim.fn.line([['"]])
        if line > 1 and line <= vim.fn.line("$") then
              vim.cmd([[normal! g`"]])
        end
      end,
})

vim.api.nvim_create_autocmd("VimResized", {
      callback = function()
        vim.cmd("wincmd =")
      end,
})

-- Filetype detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "requirements*.txt",
      callback = function()
        vim.bo.filetype = "python"
      end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = ".*aliases",
      callback = function()
        vim.bo.filetype = "sh"
      end,
})

-- Ensure tabs don't get converted to spaces in Makefiles.
vim.api.nvim_create_autocmd("FileType", {
      pattern = "make",
      callback = function()
        vim.opt_local.expandtab = false
      end,
})

-- save and load view
vim.api.nvim_create_autocmd("BufWinLeave", {
      pattern = "*.*",
      command = "mkview",
})

-- TODO: ver pq isso n ta funcionando
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--       pattern = "*.*",
--       command = "silent loadview",
-- })

-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*",
--   callback = function()
--     vim.cmd([[normal! gg=G\<C-o>zz]])
--   end,
-- })

-- change scroll offset
vim.api.nvim_create_autocmd({ "VimResized", "VimEnter", "WinEnter" }, {
      pattern = "*",
      callback = function()
        vim.o.scrolloff = math.floor(vim.fn.winheight(0) / 6)
      end,
})

-- auto-check file change from outside neovim
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
      pattern = "*",
      command = "checktime",
})

-- make gx work on packge.json (https://doriankarter.com/customize-vims-gx-mapping/)
local function package_json_gx()
      local line = vim.fn.getline(".")
      local package = vim.fn.matchlist(line, [[\v"(.*)": "(.*)"]])
      if #package > 1 then
            local name = package[2]
        local url = "https://www.npmjs.com/package/" .. name
        vim.fn["netrw#BrowseX"](url, 0)
      end
end

vim.api.nvim_create_augroup("PackageJsonGx", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      group = "PackageJsonGx",
      pattern = "package.json",
      callback = function()
        vim.keymap.set("n", "gx", package_json_gx, { buffer = true, silent = true })
      end,
})

-- TODO: make gx work on obsidian.md markdown files
-- local function obsidian_gx()
--     local line = vim.fn.getline(".")
--     local link = line:match("%[%[([^%]]+)%]%]")
--     if link then
--         -- Customize this path or command to match your system/Obsidian vault
--         local vault_path = os.getenv("HOME") .. "/Documents/ObsidianVault/"
--         local filepath = vault_path .. link .. ".md"
--         vim.cmd("edit " .. filepath)
--     end
-- end
--
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--       pattern = "*.md",
--       callback = function()
--         vim.keymap.set("n", "gx", obsidian_gx, { buffer = true, silent = true })
--       end,
-- })

-- a way of making folds look better
-- stolen originally from https://github.com/nvim-treesitter/nvim-treesitter/pull/390
_G.MyFoldText = function()
      local startLine = vim.fn.getline(vim.v.foldstart)
      local endLine = vim.fn.trim(vim.fn.getline(vim.v.foldend))

      local indent = string.rep(" ", vim.fn.indent(vim.v.foldstart))
      local fill = string.rep(" ", 200)

      return indent .. startLine .. "..." .. endLine .. fill
end

vim.opt.foldtext = 'v:lua.MyFoldText()'

-- Cria todos os diretorios necessarios para que voce consiga salvar o ARQUIVO
-- Exemplo: salvar .config/tmux/tmux.conf sendo que .config/tmux nao existe ainda
local function mk_non_ex_dir(file, buf)
      local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
  if buftype == "" and not file:match("^%w+:/") then
            local dir = vim.fn.fnamemodify(file, ":h")
    if vim.fn.isdirectory(dir) == 0 then
              vim.fn.mkdir(dir, "p")
    end
  end
end

vim.api.nvim_create_augroup("BWCCreateDir", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
      group = "BWCCreateDir",
      pattern = "*",
      callback = function(args)
        mk_non_ex_dir(vim.fn.expand("<afile>"), args.buf)
  end,
})

