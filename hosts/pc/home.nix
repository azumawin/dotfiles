{ pkgs, ... }:
{
  imports = [
    ../../configs/nvim/nvim.nix
    ../../configs/zellij/zellij.nix
    ../../configs/kitty/kitty.nix
    ../../configs/tmux/tmux.nix
    ../../configs/bash/bash.nix
    ../../configs/claude/claude.nix
    ../../configs/git/git.nix
    ../../configs/plasma-manager/plasma-manager.nix
    ../../configs/brave/brave.nix
    ../../configs/ssh/ssh.nix
  ];

  home.packages = with pkgs; [
    vim-full
    curl
    gnutar
    unzip
    wget
    ripgrep
    difftastic
    fd
    fzf
    gcc
    gnumake
    yt-dlp
    btop

    # theme
    (pkgs.callPackage ../../pkgs/nothing-theme.nix { })
    whitesur-cursors

    discord
    fastfetch
    prismlauncher
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
