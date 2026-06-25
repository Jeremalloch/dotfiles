# dotfiles
Dotfiles for vim, neovim, zsh, tmux, and git.

Run `./makesymlinks.sh` to link the dotfiles into `$HOME`.

The Neovim config lives in `nvim/init.lua`. It is linked to
`~/.config/nvim`, bootstraps `lazy.nvim`, and installs plugins with a
headless `:Lazy sync` during setup. The setup script also installs the
`tree-sitter` CLI used by `nvim-treesitter` parser installation when a known
package manager is available, then installs the configured LSP servers with
Mason.
