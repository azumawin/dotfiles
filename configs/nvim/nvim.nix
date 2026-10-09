{
  pkgs,
  ...
}:

{
  xdg.configFile."nvim".source = ./config;

  home.packages = with pkgs; [
    neovim

    # --- prerequisites for my config
    xclip # cinnamon uses x11, a different DE may need a different clipboard
    trash-cli # telescope file browser uses this
    tree-sitter

    # generally i like having language servers, linters, formatters, runtimes being in per-project flake.nix
    # but i can make an argument for having these ones here since my config requires them, although if i wanted to be purist i could put them there too.
    lua-language-server
    stylua
    nil
    nixfmt
    mdformat
    xmlformat
  ];
}
