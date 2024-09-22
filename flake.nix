{
  description = "Neovim config";

  nixConfig = {
    extra-substituters = "https://0xcharly-nixos-config.cachix.org";
    extra-trusted-public-keys = "0xcharly-nixos-config.cachix.org-1:qnguqEXJ4bEmJ8ceXbgB2R0rQbFqfWgxI+F7j4Bi6oU=";
  };

  inputs = {
    # Pin our primary nixpkgs repository.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # We use flake parts to organize our configurations.
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.git-hooks-nix.flakeModule
        inputs.treefmt-nix.flakeModule

        ./flake/cmd-fmt.nix
        ./flake/devshells.nix
      ];

      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-linux"];

      perSystem = {system, ...}: let
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.gen-luarc.overlays.default
          ];
        };
        defaultConfig = {
          src = ./nvim-config;
          runtime = [./nvim-runtime];
          patches = [];
          plugins = with pkgs.vimPlugins; [
            catppuccin-nvim
            fidget-nvim
            gitsigns-nvim
            harpoon2
            lualine-nvim
            nvim-lastplace
            nvim-lspconfig
            nvim-surround
            (nvim-treesitter.withPlugins (p:
              with p; [
                awk
                bash
                beancount
                c
                cmake
                comment
                cpp
                css
                csv
                dart
                devicetree
                dhall
                diff
                dot
                fish
                gitcommit
                gitignore
                ini
                java
                json
                just
                kdl
                kotlin
                lua
                make
                markdown
                markdown_inline
                nix
                objc
                python
                rust
                ssh_config
                starlark
                toml
                yaml
                zig
              ]))
            oil-nvim
            plenary-nvim
            sqlite-lua
            telescope-fzf-native-nvim
            telescope-nvim
            todo-comments-nvim
            # nvim-cmp and plugins
            nvim-cmp
            cmp-buffer
            cmp-path
            cmp-cmdline
            cmp-nvim-lua
            cmp-nvim-lsp
            cmp-nvim-lsp-document-symbol
            cmp-nvim-lsp-signature-help
            cmp-rg
          ];
        };
      in rec {
        _module.args = {inherit pkgs;};
        overlayAttrs.nix-config-nvim = packages.default;

        packages = rec {
          default = (pkgs.callPackage ./mk-nvim-config.nix {}) defaultConfig;

          debug-norc = default.override {src = ./.;};
          debug-no-plugins = withPlugins [];
          debug-with-zenburn = withExtraPlugins [pkgs.vimPlugins.zenburn];

          withPlugins = plugins: default.override {inherit plugins;};
          withExtraPlugins = plugins:
            default.override (prev: {plugins = prev.plugins ++ plugins;});

          # For the devshell.
          luarc-json = pkgs.mk-luarc-json {
            inherit (defaultConfig) plugins;
            nvim = pkgs.neovim-unwrapped;
            neodev-types = "stable";
          };
        };
      };
    };
}
