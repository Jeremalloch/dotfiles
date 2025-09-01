# ------------------------------------------------------------------------------
# 1. POWERLEVEL10K INSTANT PROMPT
#    - This must be at the top for near-instantaneous prompt loading.
# ------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------------------------------------------
# 2. ENVIRONMENT & EXPORTS
#    - Set basic environment variables here.
# ------------------------------------------------------------------------------
export LANG="en_US.UTF-8"
export EDITOR="vim"
export PYENV_ROOT="$HOME/.pyenv"

# ------------------------------------------------------------------------------
# 3. PATH MANAGEMENT
#    - All PATH modifications are consolidated here for clarity.
#    - Paths are prepended, so they are found before system defaults.
# ------------------------------------------------------------------------------
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH" # A common location for pipx and other tools
[[ -d "/usr/local/sbin" ]] && export PATH="/usr/local/sbin:$PATH"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# ------------------------------------------------------------------------------
# 4. OH-MY-ZSH CONFIGURATION
#    - All OMZ settings must be defined *before* sourcing oh-my-zsh.sh.
# ------------------------------------------------------------------------------
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Zsh options
HYPHEN_INSENSITIVE="true"   # Case-insensitive completion for commands with hyphens
ENABLE_CORRECTION="true"    # Enable command auto-correction

# History settings
HIST_STAMPS="mm/dd/yyyy"

# Oh-My-Zsh update settings
DISABLE_UPDATE_PROMPT="true" # Automatically update without prompting

# Performance setting for Git status in large repositories
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Suppress the "zsh compinit" insecure directories warning
ZSH_DISABLE_COMPFIX=true

# Load Oh-My-Zsh
source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------------------------
# 5. TOOL & PLUGIN CONFIGURATION
#    - Post-OMZ setup for tools like gcloud, pyenv, fzf, etc.
# ------------------------------------------------------------------------------

# Pyenv (Python Version Management)
# The `pyenv init -` command sets up shims and command completion.
eval "$(pyenv init -)"

# Google Cloud SDK
# IMPORTANT: Move your SDK out of Downloads!
# Run this command in your terminal once:
# mv ~/Downloads/google-cloud-sdk ~/google-cloud-sdk
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# fzf (Fuzzy Finder)
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# ------------------------------------------------------------------------------
# 6. ALIASES & THEME
#    - Source personal aliases and the Powerlevel10k theme config.
# ------------------------------------------------------------------------------

# Source custom aliases. Using a check makes this line safe even if the file doesn't exist.
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
