{
  inputs,
  lib,
  pkgs,
  ...
}: {
  packages = with pkgs; [
    alejandra
    stylua
  ];

  languages.lua.enable = true;
  languages.nix = {
    enable = true;
    lsp.package = pkgs.nixd;
  };

  enterShell = let
    pkgs' = import inputs.nixpkgs {
      inherit (pkgs.stdenv) system;
      overlays = [inputs.gen-luarc.overlays.default];
    };
    luarc-json = pkgs'.mk-luarc-json {
      plugins = pkgs.callPackage ./nvim-plugins.nix {
          inherit (inputs.nix-config-colorscheme.packages.${pkgs.stdenv.hostPlatform.system}) colorscheme-nvim;
      };
      nvim = pkgs.neovim-unwrapped;
    };
  in ''
    ln -fs ${luarc-json} .luarc.json
  '';

  scripts.fmt.exec = let
    fmt-opts = {
      projectRootFile = "flake.lock";
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        prettier.enable = true;
        shfmt.enable = false;
        stylua.enable = true;
        taplo.enable = true;
      };
    };
    fmt = inputs.treefmt-nix.lib.mkWrapper pkgs fmt-opts;
  in
    lib.getExe fmt;
}
