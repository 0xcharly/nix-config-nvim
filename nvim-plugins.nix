{
  vimPlugins,
  colorscheme-nvim,
  fff-nvim,
}:
with vimPlugins;
[
  blink-cmp
  conform-nvim
  nvim-lspconfig
  nvim-treesitter.withAllGrammars
  mini-nvim
  nvim-cmp
  oil-nvim
  snacks-nvim
  sqlite-lua
]
++ [
  colorscheme-nvim
  fff-nvim
]
