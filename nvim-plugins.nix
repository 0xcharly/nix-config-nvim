{
  vimPlugins,
  colorscheme-nvim,
}:
with vimPlugins;
  [
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    conform-nvim
    fff-nvim
    harpoon2
    nvim-lastplace
    nvim-lspconfig
    nvim-treesitter.withAllGrammars
    mini-nvim
    nvim-cmp
    oil-nvim
    render-markdown-nvim
    snacks-nvim
    sqlite-lua
    undotree
  ]
  ++ [
    colorscheme-nvim
  ]
