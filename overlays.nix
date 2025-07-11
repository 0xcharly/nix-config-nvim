{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.easyOverlay];

  # Injects all packages declared by this flake.
  perSystem = {config, ...}: {
    overlayAttrs = {
      nvim = config.packages.default;
      nix-config-nvim = config.packages;
    };
  };
}
