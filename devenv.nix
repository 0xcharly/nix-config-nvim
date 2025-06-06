{
  inputs,
  pkgs,
  ...
}: {
  packages = with pkgs; [
    just
    yq

    # Formatters.
    alejandra
    stylua

    (inputs.treefmt-nix.lib.mkWrapper pkgs (import ./treefmt.nix))
  ];

  languages.lua.enable = true;
  languages.nix.enable = true;
  languages.nix.lsp.package = pkgs.nixd;

  enterShell = let
    pkgs' = import inputs.nixpkgs {
      inherit (pkgs.stdenv) system;
      overlays = [inputs.gen-luarc.overlays.default];
    };
    luarc-json = pkgs'.mk-luarc-json {
      plugins = pkgs.callPackage ./nvim-plugins.nix {};
      nvim = pkgs.neovim-unwrapped;
    };
  in ''
    ln -fs ${luarc-json} .luarc.json
  '';
}
