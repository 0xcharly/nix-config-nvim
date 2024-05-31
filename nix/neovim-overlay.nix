{inputs}: final: prev: let
  mkNeovim = {
    nvim,
    plugins,
  }: let
    externalPackages = [prev.sqlite];

    normalizedPlugins =
      map
      (plugin: {
        inherit plugin;
        config = null;
        optional = false;
        runtime = {};
      })
      plugins;

    neovimConfig = final.neovimUtils.makeNeovimConfig {
      viAlias = true;
      vimAlias = true;
      withPython3 = true;
      withRuby = false;
      withNodeJs = false;
      plugins = normalizedPlugins;
    };

    nvimConfig = final.stdenv.mkDerivation {
      name = "nvim-config";
      src = ../nvim;

      buildInputs = [final.rsync];
      buildPhase = ''
        mkdir -p $out/nvim
      '';

      installPhase = ''
        rsync -a --exclude=after --exclude=/init.lua $src/ $out/nvim
        rsync -a after $out
      '';
    };

    initLua =
      ''
        vim.loader.enable()
        vim.opt.rtp:prepend('${../lib}')
      ''
      + ""
      + (builtins.readFile ../nvim/init.lua)
      + ""
      + ''
        vim.opt.rtp:prepend('${nvimConfig}/nvim')
        vim.opt.rtp:prepend('${nvimConfig}/after')
      '';

    extraMakeWrapperArgs = builtins.concatStringsSep " " [
      ''--prefix PATH : "${prev.lib.makeBinPath externalPackages}"''
      ''--set LIBSQLITE_CLIB_PATH "${final.sqlite.out}/lib/libsqlite3.so"''
      ''--set LIBSQLITE "${final.sqlite.out}/lib/libsqlite3.so"''
    ];
  in
    final.wrapNeovimUnstable nvim (neovimConfig
      // {
        luaRcContent = initLua;
        wrapperArgs = builtins.concatStringsSep " " [
          (prev.lib.escapeShellArgs neovimConfig.wrapperArgs)
          extraMakeWrapperArgs
        ];
        wrapRc = true;
      });

  # Base plugin list that is safe for corporate usage.
  base-plugins =
    (with prev.vimPlugins; [
      # Plugins pinned to the <nixpkgs> channel.
      actions-preview-nvim
      auto-hlsearch-nvim
      catppuccin-nvim
      dial-nvim
      eyeliner-nvim
      fidget-nvim
      gitsigns-nvim
      harpoon2
      lsp-status-nvim
      lspkind-nvim
      lualine-nvim
      nvim-bqf
      nvim-lastplace
      nvim-surround
      nvim-treesitter
      nvim-treesitter-textobjects
      nvim-ts-context-commentstring
      nvim-web-devicons
      oil-nvim
      plenary-nvim
      sqlite-lua
      telescope-fzf-native-nvim
      telescope-nvim
      todo-comments-nvim
      trouble-nvim
      vim-fugitive
      vim-matchup
      vim-repeat
      which-key-nvim
      # nvim-cmp and plugins
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-cmdline-history
      cmp-nvim-lua
      cmp-nvim-lsp
      cmp-nvim-lsp-document-symbol
      cmp-nvim-lsp-signature-help
      cmp-rg
    ])
    ++ (with final; [
      # Plugins from flakes.
      telescope-manix
      rustaceanvim
    ]);

  # Complete list of plugins for personal usage.
  pkg-plugins = base-plugins ++ [prev.vimPlugins.copilot-vim];

  # Complete list of plugins for corporate usage.
  pkg-corp-plugins = base-plugins;

  nvim-latest-pkg = mkNeovim {
    plugins = pkg-plugins;
    nvim = prev.neovim-unwrapped;
  };

  nvim-nightly-pkg = mkNeovim {
    plugins = pkg-plugins;
    nvim = final.neovim;
  };

  nvim-latest-corp-pkg = mkNeovim {
    plugins = pkg-corp-plugins;
    nvim = prev.neovim-unwrapped;
  };

  nvim-nightly-corp-pkg = mkNeovim {
    plugins = pkg-corp-plugins;
    nvim = final.neovim;
  };

  luarc-json = final.mk-luarc-json {
    plugins = pkg-plugins;
    nvim = final.neovim;
    neodev-types = "nightly";
  };

  corp-luarc-json = final.mk-luarc-json {
    plugins = pkg-corp-plugins;
    nvim = final.neovim;
    neodev-types = "nightly";
  };
in {
  inherit
    nvim-latest-pkg
    nvim-nightly-pkg
    nvim-latest-corp-pkg
    nvim-nightly-corp-pkg
    luarc-json
    corp-luarc-json
    ;
}
