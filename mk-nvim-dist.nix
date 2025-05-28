{
  stdenv,
  lib,
  # Neovim derivation helpers.
  neovim-unwrapped,
  wrapNeovimUnstable,
  neovimUtils,
  # Neovim config dependencies.
  rsync,
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

    # Generates the list of plugin.
    normalizePlugin = plugin: {
      inherit plugin;
      config = null;
      optional = false;
      runtime = {};
    };
    normalizePluginList = map normalizePlugin;

    # Package the config into its own derivation. Excludes `init.lua` since it's
    # inlined in `luaRcContent`.
    nvim-config = stdenv.mkDerivation {
      name = "nvim-config";
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
    # Ensures that the runtime path is prepended to RTP before including the
    # content of `init.lua`.
    # Ensures that `<config>/nvim` and `<config>/after` are also prepended to RTP.
    # Does this _after_ loading `init.lua` to guarantee a correct RTP order.
    luaRcContent = let
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
  in
    wrapNeovimUnstable package-with-patches (
      neovimUtils.makeNeovimConfig {
        inherit luaRcContent;
        wrapRc = true;

        viAlias = false;
        vimAlias = false;
        withPython3 = false;
        withRuby = false;
        withNodeJs = false;
        plugins = normalizePluginList plugins;
      }
    );
in
  lib.makeOverridable wrapper
