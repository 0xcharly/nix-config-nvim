{
  # Own colorscheme.
  colors,
  # callPackage auto arguments.
  stdenv,
  lib,
  writeText,
  # Neovim derivation helpers.
  neovim-unwrapped,
  wrapNeovimUnstable,
  neovimUtils,
  # Neovim config dependencies.
  rsync,
  # Runtime dependencies.
  alejandra,
  fzf,
  kdlfmt,
  lua-language-server,
  nixd,
  pyright,
  ripgrep,
  ruff,
  sqlite,
  stylua,
  taplo,
  yq,
}: let
  wrapper = {
    src,
    runtime ? [],
    patches ? [],
    plugins ? [],
  }: let
    # Hot-fixes to the nvim package, if any.
    package-with-patches = neovim-unwrapped.overrideAttrs (_final: prev: {
      patches = prev.patches ++ patches;
    });

    # Packages the config into its own derivation. Excludes `init.lua` since
    # it's inlined in `luaRcContent`.
    nvim-config = stdenv.mkDerivation {
      name = "nvim-config";
      inherit src;

      buildInputs = [rsync];
      buildPhase = ''
        mkdir -p $out/nvim
        mkdir -p $out/nvim/plugin
      '';

      colorscheme = writeText "colorscheme.lua" (
        with colors;
          import ./colorscheme/colorscheme.lua.nix (
            lib.attrsets.mapAttrs (_: oklch: "0x${rgbToHex (convertOklchToRgb oklch)}") theme
          )
      );

      installPhase = ''
        cp $colorscheme $out/nvim/plugin/colorscheme.lua
        rsync -a --exclude=/init.lua $src/ $out/nvim
      '';
    };

    # Wraps the user's `init.lua`.
    #
    # Ensures that the runtime path is prepended to RTP before including the
    # content of `init.lua`.
    # Ensures that `<config>/nvim` and `<config>/after` are also prepended to RTP.
    # Does this _after_ loading `init.lua` to guarantee a correct RTP order.
    customLuaRC = let
      prependAllToRtp = builtins.map (directory: "vim.opt.rtp:prepend('${directory}')");
      userConfig = [
        (nvim-config + /nvim)
        (nvim-config + /after)
      ];
      inlineContent = builtins.map (file: builtins.readFile file);
      inlinedConfig = [
        (src + /init.lua)
      ];
    in
      builtins.concatStringsSep "\n" ([
          ''
            vim.loader.enable()
          ''
        ]
        ++ (prependAllToRtp runtime)
        ++ (inlineContent inlinedConfig)
        ++ (prependAllToRtp userConfig));

    # Generates command-line flags to point to the correct version of SQLite.
    sqliteWrapperArgs = let
      sqlitePackages = [sqlite];
      sqliteLibExt = stdenv.hostPlatform.extensions.sharedLibrary;
      sqliteLibPath = "${sqlite.out}/lib/libsqlite3${sqliteLibExt}";
    in [
      "--prefix"
      "PATH"
      ":"
      "${lib.makeBinPath sqlitePackages}"
      "--set"
      "LIBSQLITE_CLIB_PATH"
      sqliteLibPath
      "--set"
      "LIBSQLITE"
      sqliteLibPath
    ];

    runtimeDeps = [
      alejandra
      fzf
      kdlfmt
      lua-language-server
      nixd
      pyright
      ripgrep
      ruff
      stylua
      taplo
      yq
    ];
    runtimeDepsWrapperArgs = [
      "--prefix"
      "PATH"
      ":"
      "${lib.makeBinPath runtimeDeps}"
    ];

    neovimConfig = neovimUtils.makeNeovimConfig {
      inherit customLuaRC;
      wrapRc = true;

      viAlias = false;
      vimAlias = false;
      withPython3 = false;
      withRuby = false;
      withNodeJs = false;
      plugins = neovimUtils.normalizePlugins plugins;
    };
  in
    wrapNeovimUnstable package-with-patches (
      neovimConfig
      // {
        # makeNeovimConfig overwrites `wrapperArgs`, hence our own overwrite below.
        withSqlite = true;
        wrapperArgs = lib.escapeShellArgs (neovimConfig.wrapperArgs ++ sqliteWrapperArgs ++ runtimeDepsWrapperArgs);
      }
    );
in
  lib.makeOverridable wrapper
