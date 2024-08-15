{
  perSystem = {...}: {
    treefmt = {
      # Used to find the project root
      projectRootFile = "flake.lock";

      programs = {
        alejandra.enable = true;
        stylua.enable = true;
      };

      settings.formatter = {};
    };
  };
}
