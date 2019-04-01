ZSH_DISABLE_COMPFIX=true
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Export for building PDK etc
export PDK_ROOT="${HOME}/pdk/pdk.latest"
export TSDK_ROOT="${PDK_ROOT}"
export TSDK_HOST_ROOT="${TSDK_ROOT}/x86_64-apple-darwin"
export TITAN_TOOLCHAIN_DIR="${TSDK_HOST_ROOT}/usr"
export TSDK_TOS_SYSROOT="${TSDK_ROOT}/sysroot/arm64-apple-titanos"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"# Aliases
alias cppcompile='c++ -std=c++11 -stdlib=libc++'
alias clr='clear; ls -F'
alias gtkk='git lg -10'
alias g++14="clang -std=c++14 -Wall -g -v"

# Set the theme and default user name
ZSH_THEME=agnoster
DEFAULT_USER="Jeremy Malloch"

plugins=(git colored-man colorize pip python brew osx common-aliases)

# User configuration
source $ZSH/oh-my-zsh.sh
alias tmux="TERM=screen-256color-bce tmux"
alias g++14="g++ -std=c++14 -Wall"
#
# Command for TensorX build
alias cmaket="/Users/test/pdk/pdk.latest/x86_64-apple-darwin/usr/bin/cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=/Users/test/pdk/pdk.latest/x86_64-apple-darwin/toolchain.cmake -DCMAKE_INSTALL_PREFIX=/Users/test/pdk/pdk.latest/sysroot/arm64-apple-titanos/usr .."

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/opencv@2/bin:$PATH"
