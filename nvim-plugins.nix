{
  vimPlugins,
  vimUtils,
  fetchFromGitHub,
  colorscheme-nvim,
}: let
  command-mode-nvim =
    (vimUtils.buildVimPlugin {
      pname = "command-mode.nvim";
      version = "v5.9.0";
      src = fetchFromGitHub {
        owner = "ej-shafran";
        repo = "compile-mode.nvim";
        rev = "v5.9.0";
        sha256 = "sha256-Us/xHSVZyRU2tozC0iu7JLIgXbC6D3geAWNLEO+IZoA=";
      };

      meta.homepage = "https://github.com/ej-shafran/compile-mode.nvim";
    }).overrideAttrs {
      dependencies = with vimPlugins; [plenary-nvim];
    };
in
  with vimPlugins;
    [
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      conform-nvim
      harpoon2
      nvim-lastplace
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      mini-nvim
      noice-nvim
      nvim-cmp
      oil-nvim
      render-markdown-nvim
      snacks-nvim
      sqlite-lua
      undotree
    ]
    ++ [
      colorscheme-nvim
      command-mode-nvim
    ]
