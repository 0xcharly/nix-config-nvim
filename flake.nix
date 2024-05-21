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

    # Plugins
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    sqlite = {
      url = "github:kkharji/sqlite.lua";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };
    eyeliner-nvim = {
      url = "github:jinh0/eyeliner.nvim";
      flake = false;
    };
    repeat = {
      url = "github:tpope/vim-repeat";
      flake = false;
    };
    surround = {
      url = "github:kylechui/nvim-surround";
      flake = false;
    };
    nvim-lastplace.url = "github:mrcjkb/nvim-lastplace";
    comment = {
      url = "github:numToStr/Comment.nvim";
      flake = false;
    };
    nio = {
      url = "github:nvim-neotest/nvim-nio";
      flake = false;
    };
    nvim-dap = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };
    nvim-dap-ui = {
      url = "github:rcarriga/nvim-dap-ui";
      flake = false;
    };
    lsp-status = {
      url = "github:nvim-lua/lsp-status.nvim";
      flake = false;
    };
    lsp_signature = {
      url = "github:ray-x/lsp_signature.nvim";
      flake = false;
    };
    nvim-lsp-selection-range = {
      url = "github:camilledejoye/nvim-lsp-selection-range";
      flake = false;
    };
    fidget = {
      url = "github:j-hui/fidget.nvim";
      flake = false;
    };
    lspkind-nvim = {
      url = "github:onsails/lspkind-nvim";
      flake = false;
    };
    actions-preview-nvim = {
      url = "github:aznhe21/actions-preview.nvim";
      flake = false;
    };
    nvim-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };
    treesitter-textobjects = {
      url = "github:nvim-treesitter/nvim-treesitter-textobjects";
      flake = false;
    };
    nvim-ts-context-commentstring = {
      url = "github:JoosepAlviste/nvim-ts-context-commentstring";
      flake = false;
    };
    vim-matchup = {
      url = "github:andymass/vim-matchup";
      flake = false;
    };
    telescope = {
      url = "github:nvim-telescope/telescope.nvim/0.1.x";
      flake = false;
    };
    telescope-manix.url = "github:mrcjkb/telescope-manix";
    telescope-smart-history = {
      url = "github:nvim-telescope/telescope-smart-history.nvim";
      flake = false;
    };
    todo-comments = {
      url = "github:folke/todo-comments.nvim";
      flake = false;
    };
    trouble = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };
    lualine = {
      url = "github:hoob3rt/lualine.nvim";
      flake = false;
    };
    oil-nvim = {
      url = "github:stevearc/oil.nvim";
      flake = false;
    };
    harpoon = {
      url = "github:ThePrimeagen/harpoon/harpoon2";
      flake = false;
    };
    gitsigns = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    nvim-bqf = {
      url = "github:kevinhwang91/nvim-bqf";
      flake = false;
    };
    rustaceanvim.url = "github:mrcjkb/rustaceanvim";
    which-key-nvim = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    # nvim-cmp and plugins.
    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    cmp-tmux = {
      url = "github:andersevenrud/cmp-tmux";
      flake = false;
    };
    cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    cmp-cmdline = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };
    cmp-cmdline-history = {
      url = "github:dmitmel/cmp-cmdline-history";
      flake = false;
    };
    cmp-nvim-lua = {
      url = "github:hrsh7th/cmp-nvim-lua";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-nvim-lsp-document-symbol = {
      url = "github:hrsh7th/cmp-nvim-lsp-document-symbol";
      flake = false;
    };
    cmp-nvim-lsp-signature-help = {
      url = "github:hrsh7th/cmp-nvim-lsp-signature-help";
      flake = false;
    };
    cmp-rg = {
      url = "github:lukas-reineke/cmp-rg";
      flake = false;
    };
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

    plugin-overlay = import ./nix/vim-plugins-overlay.nix {inherit inputs;};
    neovim-overlay = import ./nix/neovim-overlay.nix {inherit inputs;};
  in
    flake-utils.lib.eachSystem supportedSystems
    (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          gen-luarc.overlays.default
          plugin-overlay
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
