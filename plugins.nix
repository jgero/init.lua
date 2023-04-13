{ pkgs }: with pkgs.vimPlugins; [
  nvim-treesitter
  nvim-lspconfig

  onedark-nvim

  lsp_lines-nvim
  nvim-cmp
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp-cmdline
  cmp-treesitter
  luasnip
  cmp_luasnip
  friendly-snippets

  comment-nvim
  nvim-ts-context-commentstring
  vim-surround
  vim-repeat
  
  telescope-nvim
  telescope-fzf-native-nvim

  undotree
  vim-fugitive
  gitsigns-nvim
]
