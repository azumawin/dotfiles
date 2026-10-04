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
            basedpyright
            uv

            # uv owns and must add:
            # ruff - for linting
            # black - for formatting
            # python itself
          ];

          # system libraries the project requires
          env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.stdenv.cc.cc.lib
            pkgs.libz
          ];

          # dont use global python for this, only the uv installed one
          env.UV_PYTHON_PREFERENCE = "only-managed";

          # entering the venv is necessary since that puts black and ruff on path
          shellHook = ''
            uv sync --quiet
            source .venv/bin/activate
          '';
        };
      });

    };
}
