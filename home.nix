{
  config,
  pkgs,
  nixgl,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "azuma";
  home.homeDirectory = "/home/azuma";

  # Means link ~/.config/nvim to the contents of ./nvim relative to this file.
  xdg.configFile."nvim".source = ./nvim;
  xdg.configFile."zellij".source = ./zellij;
  xdg.configFile."kitty".source = ./kitty;
  # these can be changed interactively via claude, but i shouldn't do that and edit them directly instead so that my config stays completely roll-backable.
  home.file.".claude/CLAUDE.md".source = ./claude/CLAUDE.md;
  home.file.".claude/settings.json".source = ./claude/settings.json;
  home.file.".bashrc".source = ./bash/.bashrc;
  # was a leftover stow symlink that only survived because stow made it once. nothing
  # recreated it on a clean bootstrap, so a fresh machine had no git identity at all.
  home.file.".gitconfig".source = ./gitconfig/.gitconfig;

  # mutable symlinks for later if i decide to change it
  # home.file.".claude/CLAUDE.md".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/claude/CLAUDE.md";
  # home.file.".claude/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/claude/settings.json";
  # home.file.".bashrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/bash/.bashrc";

  # enable nixgl so that nix packaged apps can find opengl where nix would put it
  targets.genericLinux.enable = true;
  targets.genericLinux.nixGL.packages = nixgl.packages;
  targets.genericLinux.nixGL.defaultWrapper = "mesa";

  # without this home manager installs the font packages but never registers them
  # with fontconfig, so kitty silently falls back to DejaVu and nerd glyphs are tofu.
  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [

    # --- editor infrastructure ---
    ripgrep
    fd
    fzf
    git
    curl
    gnutar
    unzip
    wget
    gcc
    gnumake

    # --- shell ---
    bash-completion

    # --- runtimes and packages that mason needs to install language servers ---
    nodejs
    python3
    luarocks
    lua5_1

    # --- tree-sitter cli - needed for latex ---
    tree-sitter

    # --- editor, multiplexer, terminal ---
    neovim
    zellij
    (config.lib.nixGL.wrap pkgs.kitty)

    # --- fonts ---
    # cascadia-code is what kitty.conf asks for by name, lilex carries the nerd font
    # glyphs nvim and zellij draw. previously both were host fonts installed by hand.
    cascadia-code
    nerd-fonts.lilex

    # --- dev tools ---
    uv
    claude-code

    # --- media ---
    yt-dlp
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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/azuma/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
