local map = function(shortcut, command, mode)
   mode = mode or ""
   vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local nmap = function(shortcut, command)
   map(shortcut, command, 'n')
end

local vmap = function(shortcut, command)
   map(shortcut, command, 'v')
end

local imap = function(shortcut, command)
   map(shortcut, command, 'i')
end

return {map=map,nmap=nmap,vmap=vmap,imap=imap}
