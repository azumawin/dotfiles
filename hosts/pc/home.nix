{ pkgs, ... }:
{
  imports = [
    ./plasma-manager.nix
    ../../apps/nvim.nix
    ../../apps/vim.nix
    ../../apps/kitty.nix
    ../../apps/tmux.nix
    ../../apps/claude.nix
    ../../apps/git.nix
    ../../apps/ssh.nix
    ../../apps/zsh.nix
  ];

  programs.brave.enable = true;

  home.packages = with pkgs; [
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
    tree
    mpv
    lsof

    # themes
    (pkgs.callPackage ../../pkgs/nothing-theme.nix { })
    (pkgs.callPackage ../../pkgs/blackglass-theme.nix { })
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
