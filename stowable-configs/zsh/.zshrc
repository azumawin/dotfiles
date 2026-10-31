# macOS Terminal starts a login shell per window, so .zprofile or /etc/paths may have already put things
# on PATH before .zshrc runs, and nested or re-sourced shells would otherwise stack the entry up every time.
# typeset -U makes the line safe to run repeatedly instead of needing a guard.
typeset -U path PATH
path=("$HOME/.local/bin" $path)

# ========================= history ========================= 
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=10000  # commands kept in memory for this shell
SAVEHIST=100000 # commands kept in $HISTFILE across sessions
setopt INC_APPEND_HISTORY # write each command as it runs rather than at exit, so concurrent shells don't clobber each other's histories

# ========================= shell options ========================= 
# globstar is always on in zsh, not configurable
# checkwinsize is always on in zsh, not configurable
setopt CHECK_JOBS # refuse first exit if there are any running jobs, warn instead (zsh default, explicit for portability)

# ========================= completion ========================= 
autoload -Uz compinit
compinit -i # -i ignores world-writable completion dirs instead of aborting, which is what trips compinit on macos where homebrew's dirs are group-writable
unsetopt AUTO_MENU # make autocomplete feel like bash (no cycling through suggestions w tab)

# ========================= line editor (zle) =========================
# pressing esc when mid typing of a command to the shell enters vi mode
bindkey -v # use vi over emacs
KEYTIMEOUT=1 # default is 40, ie. a 0.4s pause after ESC before cmd mode engages

# bash's vi mode binds these in insert mode and zsh's doesn't, so without them
# backspace stops at the point insert mode began and ^R does nothing
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M vicmd '^R' history-incremental-search-backward

# ========================= prompt ========================= 
# bold green user@host, bold blue cwd
PROMPT='%B%F{green}%n@%m%f%b:%B%F{blue}%~%f%b%(!.#.$) '

# push user@host: cwd into the window/tab title where the terminal takes it.
# precmd runs before each prompt; print -P applies the same expansions as PROMPT.
case "$TERM" in
  xterm*|rxvt*) precmd() { print -Pn '\e]0;%n@%m: %~\a' } ;;
esac


# ========================= environment =========================                                                                                                                          
# nixos owns these via environment.sessionVariables, so it's meant for non-nixos machines.
# no guard needed becasue i want nvim in all cases
export EDITOR=nvim VISUAL=nvim
