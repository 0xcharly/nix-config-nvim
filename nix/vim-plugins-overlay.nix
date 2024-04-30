{inputs}: final: prev: let
  mkNvimPlugin = src: pname:
    prev.pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };
in {
  nvimPlugins = {
    plenary = mkNvimPlugin inputs.plenary "plenary.nvim";
    sqlite = mkNvimPlugin inputs.sqlite "sqlite.nvim";
    nvim-web-devicons = mkNvimPlugin inputs.nvim-web-devicons "nvim-web-devicons";
    eyeliner-nvim = mkNvimPlugin inputs.eyeliner-nvim "eyeliner.nvim";
    repeat = mkNvimPlugin inputs.repeat "vim-repeat";
    surround = mkNvimPlugin inputs.surround "nvim-surround";
    nvim-lastplace = mkNvimPlugin inputs.nvim-lastplace "nvim-lastplace";
    comment = mkNvimPlugin inputs.comment "comment.nvim";
    nio = mkNvimPlugin inputs.nio "nvim-nio";
    nvim-dap = mkNvimPlugin inputs.nvim-dap "nvim-dap";
    nvim-dap-ui = mkNvimPlugin inputs.nvim-dap-ui "nvim-dap-ui";
    lsp-status = mkNvimPlugin inputs.lsp-status "lsp-status.nvim";
    lsp_signature = mkNvimPlugin inputs.lsp_signature "lsp_signature.nvim";
    nvim-lsp-selection-range = mkNvimPlugin inputs.nvim-lsp-selection-range "nvim-lsp-selection-range";
    fidget = mkNvimPlugin inputs.fidget "fidget.nvim";
    nvim-cmp = mkNvimPlugin inputs.nvim-cmp "nvim-cmp";
    cmp-buffer = mkNvimPlugin inputs.cmp-buffer "cmp-buffer";
    cmp-tmux = mkNvimPlugin inputs.cmp-tmux "cmp-tmux";
    cmp-path = mkNvimPlugin inputs.cmp-path "cmp-path";
    cmp-cmdline = mkNvimPlugin inputs.cmp-cmdline "cmp-cmdline";
    cmp-cmdline-history = mkNvimPlugin inputs.cmp-cmdline-history "cmp-cmdline-history";
    cmp-nvim-lua = mkNvimPlugin inputs.cmp-nvim-lua "cmp-nvim-lua";
    cmp-nvim-lsp = mkNvimPlugin inputs.cmp-nvim-lsp "cmp-nvim-lsp";
    cmp-nvim-lsp-document-symbol = mkNvimPlugin inputs.cmp-nvim-lsp-document-symbol "cmp-nvim-lsp-document-symbol";
    cmp-nvim-lsp-signature-help = mkNvimPlugin inputs.cmp-nvim-lsp-signature-help "cmp-nvim-lsp-signature-help";
    cmp-rg = mkNvimPlugin inputs.cmp-rg "cmp-rg";
    lspkind-nvim = mkNvimPlugin inputs.lspkind-nvim "lspkind-nvim";
    actions-preview-nvim = mkNvimPlugin inputs.actions-preview-nvim "actions-preview.nvim";
    nvim-treesitter = prev.vimPlugins.nvim-treesitter.withAllGrammars;
    treesitter-textobjects = mkNvimPlugin inputs.treesitter-textobjects "treesitter-textobjects";
    treesitter-context = mkNvimPlugin inputs.treesitter-context "treesitter-context";
    nvim-ts-context-commentstring = mkNvimPlugin inputs.nvim-ts-context-commentstring "nvim-ts-context-commentstring";
    vim-matchup = mkNvimPlugin inputs.vim-matchup "vim-matchup";
    nvim-lint = mkNvimPlugin inputs.nvim-lint "nvim-lint";
    telescope = mkNvimPlugin inputs.telescope "telescope.nvim";
    telescope-manix = mkNvimPlugin inputs.telescope "telescope-manix";
    telescope-smart-history = mkNvimPlugin inputs.telescope-smart-history "telescope-smart-history.nvim";
    todo-comments = mkNvimPlugin inputs.todo-comments "todo-comments.nvim";
    lualine = mkNvimPlugin inputs.lualine "lualine";
    oil-nvim = mkNvimPlugin inputs.oil-nvim "oil.nvim";
    harpoon = mkNvimPlugin inputs.harpoon "harpoon";
    gitsigns = mkNvimPlugin inputs.gitsigns "gitsigns.nvim";
    nvim-bqf = mkNvimPlugin inputs.nvim-bqf "nvim-bqf";
    formatter = mkNvimPlugin inputs.formatter "formatter.nvim";
    yanky = mkNvimPlugin inputs.yanky "yanky.nvim";
    tmux-nvim = mkNvimPlugin inputs.tmux-nvim "tmux.nvim";
    term-edit-nvim = mkNvimPlugin inputs.term-edit-nvim "term-edit.nvim";
    other-nvim = mkNvimPlugin inputs.other-nvim "other.nvim";
    crates-nvim = mkNvimPlugin inputs.crates-nvim "crates-nvim";
    rustaceanvim = mkNvimPlugin inputs.crates-nvim "rustaceanvim";
  };
}

