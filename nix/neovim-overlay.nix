{inputs}: final: prev:
with final.lib; let
  mkNeovim = {
    appName ? null,
    nvim ? final.neovim,
    plugins ? [],
    extraPackages ? [],
    resolvedExtraLuaPackages ? [],
    extraPython3Packages ? p: [],
    withPython3 ? true,
    withRuby ? false,
    withNodeJs ? false,
    viAlias ? true,
    vimAlias ? true,
  }: let
    defaultPlugin = {
      plugin = null;
      config = null;
      optional = false;
      runtime = {};
    };

    externalPackages = extraPackages ++ [final.sqlite];

    normalizedPlugins =
      map
      (x:
        defaultPlugin
        // (
          if x ? plugin
          then x
          else {plugin = x;}
        ))
      plugins;

    neovimConfig = final.neovimUtils.makeNeovimConfig {
      inherit extraPython3Packages withPython3 withRuby withNodeJs viAlias vimAlias;
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
        vim.opt.rtp:append('${nvimConfig}/nvim')
        vim.opt.rtp:append('${nvimConfig}/after')
      '';

    extraMakeWrapperArgs = builtins.concatStringsSep " " (
      (optional (appName != "nvim" && appName != null && appName != "")
        ''--set NVIM_APPNAME "${appName}"'')
      ++ (optional (externalPackages != [])
        ''--prefix PATH : "${makeBinPath externalPackages}"'')
      ++ [
        ''--set LIBSQLITE_CLIB_PATH "${final.sqlite.out}/lib/libsqlite3.so"''
        ''--set LIBSQLITE "${final.sqlite.out}/lib/libsqlite3.so"''
      ]
    );

    extraMakeWrapperLuaCArgs = optionalString (resolvedExtraLuaPackages != []) ''
      --suffix LUA_CPATH ";" "${
        lib.concatMapStringsSep ";" final.luaPackages.getLuaCPath
        resolvedExtraLuaPackages
      }"'';

    extraMakeWrapperLuaArgs =
      optionalString (resolvedExtraLuaPackages != [])
      ''
        --suffix LUA_PATH ";" "${
          concatMapStringsSep ";" final.luaPackages.getLuaPath
          resolvedExtraLuaPackages
        }"'';
  in
    final.wrapNeovimUnstable nvim (neovimConfig
      // {
        luaRcContent = initLua;
        wrapperArgs =
          escapeShellArgs neovimConfig.wrapperArgs
          + " "
          + extraMakeWrapperArgs
          + " "
          + extraMakeWrapperLuaCArgs
          + " "
          + extraMakeWrapperLuaArgs;
        wrapRc = true;
      });

  # Base plugin list that is safe for corporate usage.
  base-plugins = with final.nvimPlugins;
    ([
        plenary
        sqlite
        nvim-web-devicons
        eyeliner-nvim
        repeat
        surround
        nvim-lastplace
        comment
        nio # TODO: Remove when rocks-dev is ready
        nvim-dap
        nvim-dap-ui
        lsp-status
        lsp_signature
        nvim-lsp-selection-range
        fidget
        lspkind-nvim
        actions-preview-nvim
        nvim-treesitter
        treesitter-textobjects
        nvim-ts-context-commentstring
        vim-matchup
        nvim-lint
        telescope
        telescope-smart-history
        todo-comments
        trouble
        lualine
        oil-nvim
        harpoon
        gitsigns
        nvim-bqf
        formatter
        yanky
        tmux-nvim
        term-edit-nvim
        other-nvim
        crates-nvim
        which-key-nvim
      ]
      ++ [
        # nvim-cmp and plugins
        cmp-buffer
        cmp-tmux
        cmp-path
        cmp-cmdline
        cmp-cmdline-history
        cmp-nvim-lua
        cmp-nvim-lsp
        cmp-nvim-lsp-document-symbol
        cmp-nvim-lsp-signature-help
        cmp-rg
        nvim-cmp
      ])
    ++ (with final; [
      telescope-manix
      rustaceanvim
    ])
    ++ (with prev.vimPlugins; [
      catppuccin-nvim
      vim-fugitive
      telescope-fzf-native-nvim
      dial-nvim
    ]);

  # Complete list of plugins for personal usage.
  pkg-plugins = base-plugins ++ [prev.vimPlugins.copilot-vim];

  # Complete list of plugins for corporate usage.
  pkg-corp-plugins = base-plugins;

  extraPackages = with final; [
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.vscode-json-languageserver-bin
    nodePackages.bash-language-server
    taplo # toml toolkit including a language server
    sqls
  ];

  nvim-pkg = mkNeovim {
    plugins = pkg-plugins;
    nvim = inputs.neovim.packages.${prev.system}.neovim;
    inherit extraPackages;
  };

  nvim-nightly-pkg = mkNeovim {
    plugins = pkg-plugins;
    nvim = final.neovim-nightly;
    inherit extraPackages;
  };

  nvim-pkg-corp = mkNeovim {
    plugins = pkg-corp-plugins;
    nvim = inputs.neovim.packages.${prev.system}.neovim;
    inherit extraPackages;
  };

  nvim-nightly-corp-pkg = mkNeovim {
    plugins = pkg-corp-plugins;
    nvim = final.neovim-nightly;
    inherit extraPackages;
  };

  luarc-json = final.mk-luarc-json {
    plugins = pkg-plugins;
    nvim = final.neovim-nightly;
    neodev-types = "nightly";
  };

  corp-luarc-json = final.mk-luarc-json {
    plugins = pkg-corp-plugins;
    nvim = final.neovim-nightly;
    neodev-types = "nightly";
  };
in {
  inherit nvim-pkg nvim-nightly-pkg nvim-pkg-corp nvim-nightly-corp-pkg luarc-json corp-luarc-json;
}