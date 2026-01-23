{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-config-colorscheme.url = "github:0xcharly/nix-config-colorscheme";
  };

  outputs =
    {
      nixpkgs,
      nix-config-colorscheme,
      ...
    }:
    let
      forAllSystems =
        fn:
        nixpkgs.lib.genAttrs (with nixpkgs.lib.platforms; darwin ++ linux) (
          system: fn nixpkgs.legacyPackages.${system}
        );
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      packages = forAllSystems (
        pkgs:
        let
          mkNvimDist = pkgs.callPackage ./mk-nvim-dist.nix { };
          nvimConfig = {
            src = ./nvim-config;
            runtime = [ ./nvim-runtime ];
            patches = [ ];
            plugins = pkgs.callPackage ./nvim-plugins.nix {
              inherit (nix-config-colorscheme.packages.${pkgs.stdenv.hostPlatform.system}) colorscheme-nvim;
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
            default.override (prev: {
              plugins = prev.plugins ++ plugins;
            });

          # A custom debug build without any configuration or plugins.
          debug-norc = default.override {
            src = ./.;
            plugins = [ ];
          };
        }
      );
    };

  nixConfig.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
}
