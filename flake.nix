{
  description = "Neovim config";

  nixConfig = {
    extra-substituters = "https://0xcharly-nixos-config.cachix.org";
    extra-trusted-public-keys = "0xcharly-nixos-config.cachix.org-1:qnguqEXJ4bEmJ8ceXbgB2R0rQbFqfWgxI+F7j4Bi6oU=";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # Plugins from flakes.
    telescope-manix.url = "github:mrcjkb/telescope-manix";
    rustaceanvim.url = "github:mrcjkb/rustaceanvim";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    pre-commit-hooks,
    ...
  }: let
    supportedSystems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];

    neovim-overlay = import ./nix/neovim-overlay.nix {inherit inputs;};
  in
    flake-utils.lib.eachSystem supportedSystems
    (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          neovim-overlay
          inputs.gen-luarc.overlays.default
          inputs.neovim-nightly-overlay.overlays.default
          inputs.telescope-manix.overlays.default
          inputs.rustaceanvim.overlays.default
        ];
      };
      shell = pkgs.mkShell {
        name = "nix-config-nvim-devShell";
        buildInputs =
          (with pre-commit-hooks.packages.${system}; [
            alejandra
            lua-language-server
            luacheck
            stylua
          ])
          ++ (with pkgs; [
            nixd
          ]);
        shellHook = ''
          ${self.checks.${system}.pre-commit-check.shellHook}
          ln -fs ${pkgs.luarc-json} .luarc.json
        '';
      };
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = self;
        hooks = {
          alejandra.enable = true;
          luacheck.enable = true;
          stylua.enable = true;
        };
      };
    in {
      packages = rec {
        default = latest;
        latest = pkgs.nvim-latest-pkg;
        latest-corp = pkgs.nvim-latest-corp-pkg;
        nightly = pkgs.nvim-nightly-pkg;
        nightly-corp = pkgs.nvim-nightly-corp-pkg;
      };
      devShells = {
        default = shell;
      };
      checks = {
        inherit pre-commit-check;
      };
    })
    // {
      overlays.default = neovim-overlay;
    };
}
