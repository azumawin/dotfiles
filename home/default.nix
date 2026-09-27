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
    ./brave/brave.nix
    ./plasma-manager/plasma-manager.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

}
