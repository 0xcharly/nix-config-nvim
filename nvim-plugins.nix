{
  vimUtils,
  fetchFromGitHub,
  vimPlugins,
}: let
  tiny-code-action-nvim = (vimUtils.buildVimPlugin
    {
      pname = "tiny-code-action.nvim";
      version = "2025-07-28";
      src = fetchFromGitHub {
        owner = "rachartier";
        repo = "tiny-code-action.nvim";
        rev = "597c4a39d5601e050d740f3ef437ee695d1ff3b0";
        sha256 = "sha256-+U1GUvfLPZ+4MPi7Q5LG8TJEWJHyS45qbg1dpBk7g98=";
      };
      meta.homepage = "https://github.com/rachartier/tiny-code-action.nvim";
      meta.hydraPlatforms = [];
    }).overrideAttrs {
    dependencies = with vimPlugins; [
      plenary-nvim
      snacks-nvim
    ];
  };

  mkTreesitterPlugins = treesitter-plugins:
    with treesitter-plugins; [
      awk
      bash
      beancount
      c
      cmake
      comment
      cpp
      css
      csv
      dart
      devicetree
      dhall
      diff
      dot
      eex
      elixir
      fish
      gitcommit
      gitignore
      heex
      html
      ini
      java
      json
      just
      kdl
      kotlin
      lua
      make
      markdown
      markdown_inline
      nix
      objc
      python
      regex
      rust
      ssh_config
      starlark
      surface
      toml
      yaml
      zig
    ];
in
  with vimPlugins; [
    # Theme.
    catppuccin-nvim
    # Convenience plugins.
    auto-hlsearch-nvim
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    conform-nvim
    elixir-tools-nvim
    fidget-nvim
    flutter-tools-nvim
    gitsigns-nvim
    harpoon2
    nvim-lastplace
    nvim-lspconfig
    (nvim-treesitter.withPlugins mkTreesitterPlugins)
    mini-nvim
    nvim-cmp
    oil-nvim
    render-markdown-nvim
    snacks-nvim
    sqlite-lua
    tiny-code-action-nvim
    todo-comments-nvim
    undotree
  ]
