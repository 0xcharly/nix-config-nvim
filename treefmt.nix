{
  projectRootFile = "flake.lock";
  programs = {
    alejandra.enable = true;
    deadnix.enable = true;
    prettier.enable = true;
    shfmt.enable = false;
    stylua.enable = true;
    taplo.enable = true;
  };
}
