{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f (import nixpkgs { inherit system; }));
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            python314
            basedpyright
            uv

            # uv owns and must add:
            # ruff - for linting
            # black - for formatting
          ];

          # system libraries the project requires
          env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.stdenv.cc.cc.lib
            pkgs.libz
          ];

          # use python from flake, don't let uv manage it
          env.UV_PYTHON_PREFERENCE = "only-system";

          # entering the venv is necessary since that puts black and ruff on path for nvim
          shellHook = ''
            uv sync --quiet
            source .venv/bin/activate
          '';
        };
      });

    };
}
