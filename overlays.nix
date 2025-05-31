{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.easyOverlay];

  # Injects all packages declared by this flake.
  perSystem = {config, ...}: {
    overlayAttrs.nix-config-nvim = config.packages;
  };
}
