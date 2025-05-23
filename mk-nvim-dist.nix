{
  stdenv,
  lib,
  # Neovim derivation helpers.
  neovim-unwrapped,
  wrapNeovimUnstable,
  neovimUtils,
  # Neovim config dependencies.
  rsync,
  sqlite,
}: let
  wrapper = {
    src,
    runtime ? [],
    package ? neovim-unwrapped,
    wrapNeovim ? wrapNeovimUnstable,
    pname ? "nvim-config",
    patches ? [],
    plugins ? [],
  }: let
    inherit (builtins) pathExists readFile readFileType;

    # Hot-fixes to the nvim package, if any.
    package-with-patches = package.overrideAttrs (_finalAttrs: prevAttrs: {
      patches = prevAttrs.patches ++ patches;
    });

    # The nvim package config pass down by `wrapNeovim`.
    neovimConfig = let
      normalizePlugin = plugin: {
        inherit plugin;
        config = null;
        optional = false;
        runtime = {};
      };
      normalizePluginList = map normalizePlugin;
    in
      neovimUtils.makeNeovimConfig {
        viAlias = false;
        vimAlias = false;
        withPython3 = true;
        withRuby = false;
        withNodeJs = false;
        plugins = normalizePluginList plugins;
      };

    # Package the config into its own derivation. Excludes `init.lua` since it's
    # inlined in `wrappedInitLua`.
    nvimConfig = stdenv.mkDerivation {
      name = pname;
      inherit src;

      buildInputs = [rsync];
      buildPhase = ''
        mkdir -p $out/nvim
      '';

      installPhase = ''
        rsync -a --exclude=/init.lua $src/ $out/nvim
      '';
    };

    # Wraps the user's `init.lua`.
    #
    # Ensures that `luaLib` is prepended to RTP before including the content of
    # `init.lua`.
    # Ensures that `<config>/nvim` and `<config>/after` are also prepended to RTP.
    # Does this _after_ loading `init.lua` to guarantee a correct RTP order.
    wrappedInitLua = let
      dirExists = path: path != null && pathExists path && readFileType path == "directory";
      initLua = src + /init.lua;

      prependRtp = builtins.map (
        path: lib.optionalString (dirExists path) "vim.opt.rtp:prepend('${path}')"
      );
    in
      builtins.concatStringsSep "\n" ([
          ''
            vim.loader.enable()
          ''
        ]
        ++ (prependRtp runtime)
        ++ [
          (lib.optionalString (pathExists initLua) (readFile initLua))
          ''
            vim.opt.rtp:prepend('${nvimConfig}/nvim')
            vim.opt.rtp:prepend('${nvimConfig}/after')
          ''
        ]);

    # Generates command-line flags to point to the correct version of SQLite.
    sqliteWrappedArgs = let
      sqlitePackages = [sqlite];
    in
      builtins.concatStringsSep " " [
        ''--prefix PATH : "${lib.makeBinPath sqlitePackages}"''
        ''--set LIBSQLITE_CLIB_PATH "${sqlite.out}/lib/libsqlite3.so"''
        ''--set LIBSQLITE "${sqlite.out}/lib/libsqlite3.so"''
      ];
  in
    wrapNeovim package-with-patches (neovimConfig
      // {
        luaRcContent = wrappedInitLua;
        wrappedArgs = lib.espcapeShellArgs (builtins.concatStringsSep " " [
          neovimConfig.wrapperArgs
          sqliteWrappedArgs
        ]);
        wrapRc = true;
      });
in
  lib.makeOverridable wrapper
