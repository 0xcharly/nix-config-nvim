{
  description = "Neovim config";

  nixConfig = {
    extra-substituters = "https://0xcharly-nixos-config.cachix.org";
    extra-trusted-public-keys = "0xcharly-nixos-config.cachix.org-1:qnguqEXJ4bEmJ8ceXbgB2R0rQbFqfWgxI+F7j4Bi6oU=";
  };

  inputs = {
    # Pin our primary nixpkgs repositories.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # We use flake parts to organize our configurations.
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";

    # Plugins from flakes.
    rustaceanvim.url = "github:mrcjkb/rustaceanvim";
  };

  outputs = inputs @ {flake-parts, ...}: let
    neovim-overlay = import ./nix/neovim-overlay.nix;
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.git-hooks-nix.flakeModule
        inputs.treefmt-nix.flakeModule

        ./flake/devshells.nix
      ];

      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-linux"];

      perSystem = {
        config,
        system,
        ...
      }: let
        pkgs = import inputs.nixpkgs-unstable {
          inherit system;
          overlays = [
            neovim-overlay
            inputs.gen-luarc.overlays.default
            inputs.neovim-nightly-overlay.overlays.default
            inputs.rustaceanvim.overlays.default
          ];
        };
      in {
        _module.args = {inherit pkgs;};
        overlayAttrs.delay-nvim-config = config.packages;
        packages = rec {
          default = latest;
          latest = pkgs.nvim-latest-pkg;
          latest-corp = pkgs.nvim-latest-corp-pkg;
          nightly = pkgs.nvim-nightly-pkg;
          nightly-corp = pkgs.nvim-nightly-corp-pkg;
        };
      };
    };
}
