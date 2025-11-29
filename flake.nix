{
  description = "Neovim config";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = {nixpkgs, ...}: let
    forAllSystems = fn:
      nixpkgs.lib.genAttrs nixpkgs.lib.platforms.linux (
        system: fn nixpkgs.legacyPackages.${system}
      );
  in {
    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: let
      mkNvimDist = pkgs.callPackage ./mk-nvim-dist.nix {};
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
  };
}
