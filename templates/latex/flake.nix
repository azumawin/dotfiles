{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      devshell,
    }:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              overlays = [ devshell.overlays.default ];
            }
          )
        );
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.devshell.mkShell {
          name = "latex";

          packages = with pkgs; [
            texliveFull
            texlab
          ];

          commands = [
            {
              name = "ltx-rebuild";
              help = "clean and rebuild latex project; usage: ltx-rebuild [path/to/main.tex]";
              # the -cd flag is necessary because latexmk resolves dependencies relative to cwd
              command = ''
                tex="''${1:-main.tex}"
                latexmk -cd -C -emulate-aux-dir -auxdir=out -outdir=. "$tex"
                latexmk -cd -lualatex -emulate-aux-dir -auxdir=out -outdir=. "$tex"
              '';
            }
          ];
        };
      });
    };
}
