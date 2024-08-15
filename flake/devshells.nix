{
  perSystem = {
    self',
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      nativeBuildInputs = [
        config.treefmt.build.wrapper
        pkgs.alejandra
        pkgs.just
        pkgs.lua-language-server
        pkgs.nixd
        pkgs.stylua
      ];

      shellHook = ''
        ${config.pre-commit.installationScript}
        ln -fs ${self'.packages.luarc-json} .luarc.json
      '';
    };

    pre-commit = {
      inherit pkgs;
      settings = {
        hooks = {
          alejandra.enable = true;
          luacheck.enable = true;
          stylua.enable = true;
        };
      };
    };

    devShells.nvim = pkgs.mkShell {
      packages = [
        self'.packages.default
      ];
    };
  };
}
