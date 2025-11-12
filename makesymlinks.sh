#!/usr/bin/env bash
# makesymlinks.sh — link dotfiles and set up zsh/oh-my-zsh/powerlevel10k
set -euo pipefail

#-----------------------------
# Config
#-----------------------------
dir="${HOME}/dotfiles"           # dotfiles directory
olddir="${HOME}/dotfiles_old"    # backup directory (created only if needed)

# List of files/folders in $dir to symlink into $HOME as dotfiles.
# Removed: ycm_extra_conf.py, neovim. Keep this in sync with your repo.
files=(
  "env.sh"
  "vimrc"
  "zshrc"
  "gitconfig"
  "zsh_aliases"
  "gitignore_global"
)

#-----------------------------
# Helpers
#-----------------------------
say() { printf "%b\n" "==> $*"; }
warn() { printf "%b\n" "!!  $*" >&2; }

ensure_dir() {
  local d="$1"
  [ -d "$d" ] || mkdir -p "$d"
}

backup_dir_created=false
maybe_create_backup_dir() {
  if [ "$backup_dir_created" = false ]; then
    say "Creating backup directory at $olddir ..."
    mkdir -p "$olddir"
    backup_dir_created=true
  fi
}

backup_if_needed_and_link() {
  local name="$1"
  local src="${dir}/${name}"
  local dst="${HOME}/.${name}"

  if [ ! -e "$src" ] && [ ! -L "$src" ]; then
    warn "Skipping '${name}': not found in ${dir}."
    return 0
  fi

  # If destination exists (file/dir/symlink), decide what to do
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    # If it's already the correct symlink, do nothing
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
      say "Already linked: ${dst} -> ${src}"
    else
      maybe_create_backup_dir
      say "Backing up existing ${dst} -> ${olddir}/"
      mv -f "$dst" "$olddir"/
      ln -sfn "$src" "$dst"
      say "Linked ${dst} -> ${src}"
    fi
  else
    ln -sfn "$src" "$dst"
    say "Linked ${dst} -> ${src}"
  fi
}

#-----------------------------
# Sanity check
#-----------------------------
if [ ! -d "$dir" ]; then
  warn "Dotfiles directory not found at ${dir}."
  warn "Edit 'dir' at the top of this script or clone your repo to ${dir}."
  exit 1
fi

#-----------------------------
# Create symlinks (with smart backups)
#-----------------------------
say "Linking dotfiles from ${dir} into ${HOME}"
for file in "${files[@]}"; do
  backup_if_needed_and_link "$file"
done

# Configure Git global ignore if the file exists
if [ -f "${HOME}/.gitignore_global" ]; then
  if git config --global --get core.excludesfile >/dev/null; then
    say "Git core.excludesfile already set to: $(git config --global --get core.excludesfile)"
  else
    git config --global core.excludesfile "${HOME}/.gitignore_global"
    say "Set git core.excludesfile to ~/.gitignore_global"
  fi
fi

#-----------------------------
# Install / ensure zsh
#-----------------------------
install_zsh() {
  if command -v zsh >/dev/null 2>&1; then
    say "zsh already installed."
  else
    local platform
    platform="$(uname -s)"
    case "$platform" in
      Linux)
        if [ -f /etc/redhat-release ] || command -v dnf >/dev/null 2>&1; then
          sudo dnf -y install zsh || sudo yum -y install zsh
        elif [ -f /etc/debian_version ] || command -v apt-get >/dev/null 2>&1; then
          sudo apt-get update -y
          sudo apt-get install -y zsh
        else
          warn "Unknown Linux distro—please install zsh manually."
        fi
        ;;
      Darwin)
        if command -v brew >/dev/null 2>&1; then
          brew install zsh
        else
          warn "Homebrew not found. Install Homebrew or zsh manually: https://brew.sh"
        fi
        ;;
      *)
        warn "Unsupported platform: ${platform}. Install zsh manually."
        ;;
    esac
  fi

  # Make zsh the default shell if it's not already
  if [ "${SHELL:-}" != "$(command -v zsh)" ] && command -v zsh >/dev/null 2>&1; then
    say "Changing default shell to zsh ..."
    chsh -s "$(command -v zsh)" || warn "Could not change default shell automatically."
  fi
}

install_zsh

#-----------------------------
# oh-my-zsh
#-----------------------------
install_oh_my_zsh() {
  local omz_dir="${HOME}/.oh-my-zsh"
  if [ -d "$omz_dir" ]; then
    say "oh-my-zsh already present at ${omz_dir}"
    return
  fi
  if command -v curl >/dev/null 2>&1; then
    say "Installing oh-my-zsh ..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  elif command -v wget >/dev/null 2>&1; then
    say "Installing oh-my-zsh ..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    warn "curl/wget not available—install oh-my-zsh manually."
  fi
}

install_oh_my_zsh

#-----------------------------
# powerlevel10k theme
#-----------------------------
install_powerlevel10k() {
  local omz_dir="${HOME}/.oh-my-zsh"
  local custom="${ZSH_CUSTOM:-${omz_dir}/custom}"
  local theme_dir="${custom}/themes/powerlevel10k"

  if [ ! -d "$omz_dir" ]; then
    warn "oh-my-zsh not found—skipping powerlevel10k install."
    return
  fi

  if [ -d "$theme_dir" ]; then
    say "powerlevel10k already installed."
  else
    say "Installing powerlevel10k ..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$theme_dir"
  fi

  # Ensure ZSH_THEME is set to powerlevel10k in ~/.zshrc (which is now symlinked)
  if [ -f "${HOME}/.zshrc" ]; then
    if grep -q '^ZSH_THEME=' "${HOME}/.zshrc"; then
      if grep -q '^ZSH_THEME="powerlevel10k/powerlevel10k"' "${HOME}/.zshrc"; then
        say "ZSH_THEME already set to powerlevel10k."
      else
        say "Updating ZSH_THEME to powerlevel10k in .zshrc"
        # Make an inline backup once; your script already backs up original .zshrc if it existed
        sed -i.bak 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "${HOME}/.zshrc"
      fi
    else
      say "Adding ZSH_THEME to .zshrc"
      printf '\nZSH_THEME="powerlevel10k/powerlevel10k"\n' >> "${HOME}/.zshrc"
    fi
  else
    warn "~/.zshrc not found to configure theme (was it skipped?)."
  fi
}

install_powerlevel10k

#-----------------------------
# Ensure vim present (no Neovim)
#-----------------------------
ensure_vim() {
  if command -v vim >/dev/null 2>&1; then
    say "vim is installed."
    return
  fi
  local platform
  platform="$(uname -s)"
  case "$platform" in
    Linux)
      if command -v dnf >/dev/null 2>&1; then
        sudo dnf -y install vim
      elif command -v yum >/dev/null 2>&1; then
        sudo yum -y install vim
      elif command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update -y
        sudo apt-get install -y vim
      else
        warn "Unknown Linux package manager—install vim manually."
      fi
      ;;
    Darwin)
      if command -v brew >/dev/null 2>&1; then
        brew install vim
      else
        warn "Homebrew not found. Install Homebrew or vim manually."
      fi
      ;;
    *)
      warn "Unsupported platform: ${platform}. Install vim manually."
      ;;
  esac
}
ensure_vim

say "All done!"
if [ "$backup_dir_created" = true ]; then
  say "Backups saved in ${olddir}"
fi

