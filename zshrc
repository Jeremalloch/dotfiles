ZSH_DISABLE_COMPFIX=true

# oh-my-zsh settings
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
ZSH_THEME=powerlevel10k/powerlevel10k
HYPHEN_INSENSITIVE="true"
# Automatically update oh-my-zsh without prompting
DISABLE_UPDATE_PROMPT="true"
# This makes repository status check for large repositories
DISABLE_UNTRACKED_FILES_DIRTY="true" 
source $ZSH/oh-my-zsh.sh

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR="nvim"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Source the custom aliases
source ~/.zsh_aliases

# Set the theme and default user name
DEFAULT_USER="Jeremy Malloch"

export PATH="/usr/local/sbin:$PATH"
