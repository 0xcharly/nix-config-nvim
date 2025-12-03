{
  description = "Neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-math.url = "github:xddxdd/nix-math";
  };

  outputs = {
    nixpkgs,
    nix-math,
    ...
  }: let
    forAllSystems = fn:
      nixpkgs.lib.genAttrs (with nixpkgs.lib.platforms; darwin ++ linux) (
        system: fn nixpkgs.legacyPackages.${system}
      );
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: let
      mkNvimDist = pkgs.callPackage ./mk-nvim-dist.nix {
        colors = import ./colors.nix nixpkgs.lib nix-math.lib.math;
      };
      nvimConfig = {
        src = ./nvim-config;
        runtime = [./nvim-runtime];
        patches = [];
        plugins = pkgs.callPackage ./nvim-plugins.nix {};
      };
    in rec {
      # The default package that bundles the entire neoviw configuration
      # without any dependency.
      default = mkNvimDist nvimConfig;

      # Augment the default package with more plugins.
      withExtraPlugins = plugins:
        default.override (prev: {plugins = prev.plugins ++ plugins;});

      # A custom build with an extra lush-nvim plugin to work on the theme.
      debug-colorscheme = withExtraPlugins [pkgs.vimPlugins.lush-nvim];

      # A custom debug build without any configuration or plugins.
      debug-norc = default.override {
        src = ./.;
        plugins = [];
      };
    });

    lib = import ./colors.nix nixpkgs.lib nix-math.lib.math;
  };
}
