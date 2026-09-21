{
  pkgs,
  ...
}:

{
  # these can be changed interactively via claude, but i shouldn't do that and edit them directly instead so that my config stays completely roll-backable.
  xdg.configFile."kitty".source = ./config;

  # without this home manager installs the font packages but never registers them
  # with fontconfig, so kitty silently falls back to DejaVu and nerd glyphs are tofu.
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    kitty

    # cascadia-mono is what kitty.conf asks for by name, lilex carries the nerd font
    # glyphs nvim and zellij draw. previously both were host fonts installed by hand.
    cascadia-code
    nerd-fonts.lilex
  ];
}
