# entry point for the per-user (home-manager) side of this repo, as opposed to
# hosts/ which is the system side. declares who the user is and imports every
# per-user module; actual packages and app config live in those modules.
{

  imports = [
    ./apps.nix
    ./nvim/nvim.nix
    ./zellij/zellij.nix
    ./kitty/kitty.nix
    ./tmux/tmux.nix
    ./bash/bash.nix
    ./claude/claude.nix
    ./git/git.nix
  ];
  home.username = "azuma";
  home.homeDirectory = "/home/azuma";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
