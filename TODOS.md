# TODO

- i need to decide on what apps should go to configuration.nix as programs.enable and packages and
  what apps should go to home.nix,

- need to test gnu stow in a vm and also set some macos options to make tmux and stuff work since
  diff shortcuts

- symlink .bashrc instead of using bash.nix so i could port same .bashrc on non-nixos systems since
  ill use gnu stow there, since work laptop requires sudo to install nix

- figure out what part of the dotfiles i'd want on a work machine and how to set it up (would prefer
  to use nix but can use gnu stow if no root)

- explore `sudo nixos-rebuild` possible subcommands, it has some pretty cool stuff like build-image,
  builv-vm, etc.

- install nix-index

- need to add uni-assignment that has latex and python and then add main.tex into latex and
  uni-assignment templates

- add direnv

- add proper CLAUDE.md and settings.json, guardrails

- flake.nix should determine my system from hardware-configuration.nix or something, i shouldnt have
  to hardcode it.

- setup vim fugitive for more granular staging

- clean up and document the latex packages

- setup latex snippets eventually

- java setup with ftplugin is deprecated for now, will fix next time i need it.
