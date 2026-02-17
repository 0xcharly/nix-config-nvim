{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    colorscheme = {
      url = "github:0xcharly/nix-config-colorscheme";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fff = {
      url = "github:dmtrKovalenko/fff.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      forAllSystems =
        fn:
        nixpkgs.lib.genAttrs (with nixpkgs.lib.platforms; darwin ++ linux) (
          system: fn nixpkgs.legacyPackages.${system}
        );
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt);

      packages = forAllSystems (
        pkgs:
        let
          inherit (pkgs.stdenv.hostPlatform) system;
          mkNvimDist = pkgs.callPackage ./mk-nvim-dist.nix { };
          nvimConfig = {
            src = ./nvim-config;
            runtime = [ ./nvim-runtime ];
            patches = [ ];
            plugins = pkgs.callPackage ./nvim-plugins.nix {
              inherit (inputs.colorscheme.packages.${system}) colorscheme-nvim;
              inherit (inputs.fff.packages.${system}) fff-nvim;
            };
          };
        in
        rec {
          # The default package that bundles the entire neoviw configuration
          # without any dependency.
          default = mkNvimDist nvimConfig;

          # Augment the default package with more plugins.
          withExtraPlugins =
            plugins:
            default.override (old: {
              plugins = (old.plugins or [ ]) ++ plugins;
            });

          # A custom debug build without any configuration or plugins.
          debug-norc = default.override {
            src = ./.;
            plugins = [ ];
          };
        }
      );
    };

  nixConfig.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];
}
