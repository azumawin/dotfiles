{
  pkgs,
  ...
}:

{
  xdg.configFile."nvim".source = ./config;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.packages = with pkgs; [
    neovim

    # --- prerequisites for my config
    xclip # cinnamon uses x11, a different DE may need a different clipboard
    trash-cli # telescope file browser uses this
    tree-sitter
    # --- runtimes that nvim plugins shell out to ---
    # nodejs is for markdown-preview/live-server, lua5_1+luarocks for lua tooling
    nodejs
    luarocks
    lua5_1
    # default libraries like tkinter ship with the interpreter so i need to add them here, very rarely do i encounter this
    (python3.withPackages (ps: with ps; [ tkinter ]))

    # generally i like having language servers, linters, formatters, runtimes being in per-project flake.nix
    # but i can make an argument for having them here since my config requires them, although if i wanted to be purist i could put them there too.
    lua-language-server
    nil
    nixfmt
    stylua
    mdformat
    xmlformat
  ];
}
