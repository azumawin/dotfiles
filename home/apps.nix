{ pkgs, ... }:
{

  home.packages = with pkgs; [
    # base cli tools with no config
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

    # apps (potentially nix owned config)
    firefox
    zathura
    (pkgs.callPackage ../pkgs/hashcards.nix { })
    rpi-imager

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # nix owned config (programs.<name>.enable)
}
