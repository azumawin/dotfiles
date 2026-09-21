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

    #prerequisites for my config
    xclip # cinnamon uses x11, a different DE may need a different clipboard
    trash-cli # telescope file browser uses this
    tree-sitter

    # --- maybe this should be per project? still need to decide.
    # language servers (note that the some language servers are also linters, so it can overlap)
    basedpyright
    pyright # not in vim.lsp.enable, kept because mason had it
    ruff # doubles as the python linter for nvim-lint
    lua-language-server
    nil # nix
    texlab # latex
    clang-tools # clangd + clang-format come from the same package
    rust-analyzer
    roslyn-ls # c#; roslyn.nvim falls back to Microsoft.CodeAnalysis.LanguageServer on PATH
    jdt-language-server # ships the `jdtls` wrapper that ftplugin/java.lua launches

    # formatters
    black
    nixfmt
    rustfmt
    csharpier
    google-java-format
    stylua
    # uncomment only if u want latex installed on the machine as it takes a long time.
    # texliveFull
    mdformat
    pgformatter # binary is `pg_format`
    taplo
    xmlformat # conform's `xmlformatter` just calls `xmlformat -`, which this provides
    prettier

    # linters
    lua51Packages.luacheck
    vale

    # --- runtimes that nvim plugins shell out to ---
    # nodejs is for markdown-preview/live-server, lua5_1+luarocks for lua tooling
    nodejs
    # default libraries like tkinter ship with the interpreter so i need to add them here, very rarely do i encounter this
    (python3.withPackages (ps: with ps; [ tkinter ]))
    luarocks
    lua5_1
  ];
}
