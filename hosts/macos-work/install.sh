#!/usr/bin/env bash
# install.sh -- set up a work macbook for SOME of the configs in stowable-configs/.
# needs no sudo, except for the two things it only ever points at: the xcode
# command line tools, and homebrew in its default prefix.
# re-runnable: brew skips what's there, stow --restow re-links.

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

PACKAGES=(
  curl
  gnu-tar
  unzip
  wget
  ripgrep
  difftastic
  fd
  fzf
  gcc
  make
  btop
  tree

  neovim
  vim
  tmux
  stow
  git
  tree-sitter # nvim-treesitter's build step shells out to the cli
  trash-cli   # telescope file_browser's `d` calls trash-put
)

FONTS=(
  font-cascadia-mono # kitty.conf asks for "Cascadia Mono" by name
  font-lilex-nerd-font # the nerd glyphs nvim draws
)

STOW=(kitty nvim vim tmux git zsh)

#==========#
# homebrew #
#==========#
if ! command -v brew >/dev/null 2>&1; then
  for p in /opt/homebrew /usr/local "$HOME/homebrew"; do
    [ -x "$p/bin/brew" ] && eval "$("$p/bin/brew" shellenv)" && break
  done
fi

if ! command -v brew >/dev/null 2>&1; then
  cat >&2 <<'MSG'
no homebrew. with admin, use the default prefix (the only one with prebuilt bottles):
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
without admin, clone it instead -- but then every formula builds from source:
  git clone --depth=1 https://github.com/Homebrew/brew ~/homebrew
either way, add the shellenv line to ~/.zprofile so it stays on PATH:
  eval "$(<prefix>/bin/brew shellenv)"
MSG
  exit 1
fi

echo "==> homebrew at $(brew --prefix)"
brew update

echo "==> packages"
brew install "${PACKAGES[@]}"

echo "==> fonts"
brew install --cask "${FONTS[@]}"

#=======#
# kitty #
#=======#
# the cask wants /Applications, which a non-admin user can't write to. this
# installer unpacks into ~/.local and brings the xterm-kitty terminfo entry
# that tmux.conf's terminal-features line names.
if [ -x "$HOME/.local/kitty.app/bin/kitty" ]; then
  echo "==> kitty already installed"
else
  echo "==> kitty"
  curl -fsSL https://sw.kovidgoyal.net/kitty/installer.sh |
    sh /dev/stdin launch=n dest="$HOME/.local"
  mkdir -p "$HOME/.local/bin" "$HOME/Applications"
  ln -sf "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/kitty"
  ln -sf "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/kitten"
  ln -sfn "$HOME/.local/kitty.app" "$HOME/Applications/kitty.app"
fi

# UNCOMMENT AND ADD CLAUDE TO STOW IF THEY ALLOW IT
#=============#
# claude code #
#=============#
# if command -v claude >/dev/null 2>&1; then
#   echo "==> claude code already installed"
# else
#   echo "==> claude code (cleared with whoever owns the policy here?)"
#   curl -fsSL https://claude.ai/install.sh | bash
# fi

#======#
# stow #
#======#
# ~/.config up front so stow links the leaves rather than folding the whole
# directory into the first package it stows.
mkdir -p "$HOME/.config"
echo "==> stow: ${STOW[*]}"
stow --dir="$DOTFILES/stowable-configs" --target="$HOME" --restow "${STOW[@]}"

#========#
# checks #
#========#
# tmux.conf sets default-terminal tmux-256color and some macos ncurses builds
# don't carry the entry, in which case tmux refuses to start.
if ! infocmp tmux-256color >/dev/null 2>&1; then
  echo "!!  no tmux-256color terminfo. fix it for your user only:" >&2
  echo "!!    brew install ncurses" >&2
  echo "!!    /usr/bin/tic -x -o ~/.terminfo \"\$(brew --prefix ncurses)\"/share/terminfo/t/tmux-256color" >&2
fi

cat <<MSG

done. then:
  nvim                      # lazy.nvim bootstraps itself and installs parsers
  git config user.email ... # .gitconfig sets useConfigOnly, so every repo needs one
MSG
