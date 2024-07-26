{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        # Nix.
        alejandra
        lua-language-server
        luacheck
        nixd

        # Lua.
        stylua
      ];

      shellHook = ''
        ${config.pre-commit.installationScript}
        ln -fs ${pkgs.luarc-json} .luarc.json
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
  };
}
