{ pkgs, ... }:
{

  home.packages = with pkgs; [
    vim
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

    # config potentially owned by nix
    zathura
    (pkgs.callPackage ../pkgs/hashcards.nix { })
    rpi-imager

    (pkgs.callPackage ../pkgs/nothing-theme.nix { })
    whitesur-cursors
  ];
}
