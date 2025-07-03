{vimPlugins}: let
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
      fish
      gitcommit
      gitignore
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
      toml
      yaml
      zig
    ];
in
  with vimPlugins; [
    # Foundation plugins.
    plenary-nvim
    # Theme.
    catppuccin-nvim
    # Convenience plugins.
    auto-hlsearch-nvim
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    conform-nvim
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
    snacks-nvim
    sqlite-lua
    todo-comments-nvim
    undotree
  ]
