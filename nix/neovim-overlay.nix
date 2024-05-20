{inputs}: final: prev: let
  mkNeovim = {
    appName ? null,
    nvim ? prev.neovim,
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

    externalPackages = extraPackages ++ [prev.sqlite];

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
      (prev.lib.optional (appName != "nvim" && appName != null && appName != "")
        ''--set NVIM_APPNAME "${appName}"'')
      ++ (prev.lib.optional (externalPackages != [])
        ''--prefix PATH : "${prev.lib.makeBinPath externalPackages}"'')
      ++ [
        ''--set LIBSQLITE_CLIB_PATH "${final.sqlite.out}/lib/libsqlite3.so"''
        ''--set LIBSQLITE "${final.sqlite.out}/lib/libsqlite3.so"''
      ]
    );

    extraMakeWrapperLuaCArgs = prev.lib.optionalString (resolvedExtraLuaPackages != []) ''
      --suffix LUA_CPATH ";" "${
        prev.lib.concatMapStringsSep ";" final.luaPackages.getLuaCPath
        resolvedExtraLuaPackages
      }"'';

    extraMakeWrapperLuaArgs =
      prev.lib.optionalString (resolvedExtraLuaPackages != [])
      ''
        --suffix LUA_PATH ";" "${
          prev.lib.concatMapStringsSep ";" final.luaPackages.getLuaPath
          resolvedExtraLuaPackages
        }"'';
  in
    final.wrapNeovimUnstable nvim (neovimConfig
      // {
        luaRcContent = initLua;
        wrapperArgs =
          prev.lib.escapeShellArgs neovimConfig.wrapperArgs
          + " "
          + extraMakeWrapperArgs
          + " "
          + extraMakeWrapperLuaCArgs
          + " "
          + extraMakeWrapperLuaArgs;
        wrapRc = true;
      });

  # Base plugin list that is safe for corporate usage.
  base-plugins =
    (with final.nvimPlugins;
      [
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
      auto-hlsearch-nvim
      catppuccin-nvim
      vim-fugitive
      telescope-fzf-native-nvim
      dial-nvim
    ]);

  # Complete list of plugins for personal usage.
  pkg-plugins = base-plugins ++ [prev.vimPlugins.copilot-vim];

  # Complete list of plugins for corporate usage.
  pkg-corp-plugins = base-plugins;

  nvim-pkg = mkNeovim {
    plugins = pkg-plugins;
    nvim = inputs.neovim.packages.${prev.system}.neovim;
  };

  nvim-nightly-pkg = mkNeovim {
    plugins = pkg-plugins;
    nvim = inputs.neovim-nightly.packages.${prev.system}.neovim;
  };

  nvim-pkg-corp = mkNeovim {
    plugins = pkg-corp-plugins;
    nvim = inputs.neovim.packages.${prev.system}.neovim;
  };

  nvim-nightly-corp-pkg = mkNeovim {
    plugins = pkg-corp-plugins;
    nvim = inputs.neovim-nightly.packages.${prev.system}.neovim;
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
  inherit nvim-pkg nvim-nightly-pkg nvim-pkg-corp nvim-nightly-corp-pkg luarc-json corp-luarc-json;
}
