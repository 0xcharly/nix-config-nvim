{
  description = "Neovim config";

  nixConfig = {
    extra-substituters = "https://0xcharly-nixos-config.cachix.org";
    extra-trusted-public-keys = "0xcharly-nixos-config.cachix.org-1:qnguqEXJ4bEmJ8ceXbgB2R0rQbFqfWgxI+F7j4Bi6oU=";
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";

    neovim = {
      # NOTE: temporary workaround while the neovim flakes moves to the community repo:
      # https://github.com/nix-community/neovim-nightly-overlay/pull/483
      url = "github:0xcharly/neovim/v0.10.0?dir=contrib";
      # url = "github:neovim/neovim/v0.10.0?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly = {
      # NOTE: temporary workaround while the neovim flakes moves to the community repo:
      # https://github.com/nix-community/neovim-nightly-overlay/pull/483
      url = "github:0xcharly/neovim?dir=contrib";
      # url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Plugins from flakes.
    telescope-manix.url = "github:mrcjkb/telescope-manix";
    rustaceanvim.url = "github:mrcjkb/rustaceanvim";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    gen-luarc,
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
          gen-luarc.overlays.default
          neovim-overlay
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
        default = stable;
        stable = pkgs.nvim-pkg;
        stable-corp = pkgs.nvim-pkg-corp;
        nightly = pkgs.nvim-nightly-pkg;
        nightly-corp = pkgs.nvim-nightly-corp-pkg;
        nightly-zero-conf = pkgs.neovim-nightly;
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
