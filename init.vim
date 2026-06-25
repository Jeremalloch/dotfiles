" Legacy Neovim entrypoint.
" The canonical config lives in ~/dotfiles/nvim/init.lua and is linked to
" ~/.config/nvim by makesymlinks.sh.
lua dofile(vim.fn.expand("~/dotfiles/nvim/init.lua"))
