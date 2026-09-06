{
  description = "Home Manager configuration of azuma";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixgl.url = "github:nix-community/nixGL";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixgl,
      ...
    }:
    let
      system = "x86_64-linux";
      # claude-code is unfree, so nixpkgs needs instantiating with a config
      # rather than taken from legacyPackages. kept as a predicate instead of
      # allowUnfree so nothing else slips in unnoticed.
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "claude-code" ];
      };
    in
    {
      homeConfigurations."azuma" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # nix packaged gui apps expect OpenGL at /run/opengl-driver/, but on non-nixos systems the path isnt there so we add it through home manager
        extraSpecialArgs = { inherit nixgl; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
