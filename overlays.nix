{
  inputs,
  withSystem,
  ...
}: {
  imports = [inputs.flake-parts.flakeModules.easyOverlay];

  # Injects all packages declared by this flake.
  perSystem = {config, ...}: {
    overlayAttrs.nix-config-nvim = config.packages;
  };

  # Overrides `pkgs.nvim` package with the distribution declared by this flake.
  flake.overlays.nvim-override = _final: prev:
    withSystem prev.stdenv.hostPlatform.system (
      {config, ...}: {
        nvim = config.packages.default;
      }
    );
}
