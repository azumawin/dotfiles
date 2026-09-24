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

    # config potentially owned by nix
    firefox
    zathura
    (pkgs.callPackage ../pkgs/hashcards.nix { })
    rpi-imager

  ];
}
