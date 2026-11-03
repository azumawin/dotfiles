#!/usr/bin/env bash
# install.sh -- set up a work macbook for SOME of the configs in stowable-configs/.
# assumes an admin account: homebrew goes in its default prefix and casks land in
# /Applications, both of which want sudo.
# re-runnable: brew skips what's there, stow --restow re-links.

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

PACKAGES=(
  gnu-tar
  wget
  ripgrep
  difftastic
  fd
  fzf
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

CASKS=(
  kitty
  font-cascadia-mono   # kitty.conf asks for "Cascadia Mono" by name
  font-lilex-nerd-font # the nerd glyphs nvim draws
)

STOW=(kitty nvim vim tmux git zsh)

# a plain string, not an array: macos /bin/bash is 3.2, where an empty array
# under `set -u` is an unbound-variable error.
SKIPPED=""

#==========#
# homebrew #
#==========#
# the installer pulls in the xcode command line tools too, and asks for the
# sudo password itself.
if ! command -v brew >/dev/null 2>&1; then
  [ -x /opt/homebrew/bin/brew ] || [ -x /usr/local/bin/brew ] ||
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

# .zprofile, not .zshrc: the stowed .zshrc is shared with nixos, and this prefix
# is a mac-only detail. login shells read it before .zshrc either way.
BREW_LINE="eval \"\$($(brew --prefix)/bin/brew shellenv)\""
if ! grep -qsF "$BREW_LINE" "$HOME/.zprofile"; then
  echo "==> adding brew shellenv to ~/.zprofile"
  echo "$BREW_LINE" >>"$HOME/.zprofile"
fi

echo "==> homebrew at $(brew --prefix)"
brew update

echo "==> packages"
brew install "${PACKAGES[@]}"

#======#
# stow #
#======#
# as early as the stow formula allows, which is right here. the casks and the
# claude installer below are the steps that need a password or the network, and
# under `set -e` a failure in either used to abort the script before it ever got
# to the linking -- the cheapest and most important part.
#
# one package per stow call, deliberately. stow aborts the WHOLE invocation on a
# single conflict ("All operations aborted"), so passing all six at once means an
# existing ~/.zshrc costs you the other five. per-package, a conflict skips just
# that one and leaves the existing file untouched.
#
# ~/.config up front so stow links the leaves rather than folding the whole
# directory into the first package it stows.
mkdir -p "$HOME/.config"
for p in "${STOW[@]}"; do
  if out=$(stow --dir="$DOTFILES/stowable-configs" --target="$HOME" --restow "$p" 2>&1); then
    echo "==> stowed $p"
  else
    # also what keeps `set -e` from killing the script on the first conflict
    SKIPPED="$SKIPPED $p"
    echo "!!  skipped $p, left the existing file alone:" >&2
    echo "$out" | sed 's/^/!!    /' >&2
  fi
done

echo "==> casks"
brew install --cask "${CASKS[@]}"

#=============#
# claude code #
#=============#
if command -v claude >/dev/null 2>&1; then
  echo "==> claude code already installed"
else
  echo "==> claude code (cleared with whoever owns the policy here?)"
  curl -fsSL https://claude.ai/install.sh | bash
fi

#========#
# checks #
#========#
# tmux.conf sets default-terminal tmux-256color and some macos ncurses builds
# don't carry the entry, in which case tmux refuses to start.
if ! infocmp tmux-256color >/dev/null 2>&1; then
  echo "!!  no tmux-256color terminfo:" >&2
  echo "!!    brew install ncurses" >&2
  echo "!!    sudo tic -x -o /usr/share/terminfo \"\$(brew --prefix ncurses)\"/share/terminfo/t/tmux-256color" >&2
fi

cat <<MSG

done. open a new shell, then:
  nvim                      # lazy.nvim bootstraps itself and installs parsers
  git config user.email ... # .gitconfig sets useConfigOnly, so every repo needs one
MSG

# repeated at the very end on purpose: a conflict warning printed before the brew
# cask output has scrolled well out of sight by now.
if [ -n "$SKIPPED" ]; then
  cat >&2 <<MSG

!!  not stowed, you still have the machine's own copy:$SKIPPED
!!  diff one against the repo, and if there's nothing worth keeping:
!!    mv ~/.zshrc ~/.zshrc.bak   # or whichever file it named above
!!    ./install.sh               # re-runnable, picks up where this left off
MSG
fi
