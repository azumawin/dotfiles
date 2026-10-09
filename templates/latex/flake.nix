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
              overlays = [
                devshell.overlays.default
                # TL2025 ships minted 3.7.0, whose bundled latexminted 0.6.0 crashes on
                # python 3.14 (argparse injects color= into ArgParser). fixed upstream in
                # latexminted 0.7.0 / minted 3.8.0, not in nixpkgs yet; drop this once
                # https://github.com/NixOS/nixpkgs/pull/569745 lands.
                # must be an overlay: texlive takes itself as an argument and withPackages
                # builds from that self reference, so a plain texlive.override is ignored.
                (final: prev: {
                  texlive = prev.texlive.override { python3 = final.python313; };
                })
              ];
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
              # unset SOURCE_DATE_EPOCH fixes lualatex resolving \today as 1980 January 1st
              command = ''
                tex="''${1:-main.tex}"
                unset SOURCE_DATE_EPOCH
                latexmk -cd -C -emulate-aux-dir -auxdir=out -outdir=. "$tex"
                latexmk -cd -shell-escape -lualatex -emulate-aux-dir -auxdir=out -outdir=. "$tex"
              '';
            }
          ];
        };
      });
    };
}
