{ pkgs }: with pkgs.vimPlugins;
let
  transparent = pkgs.vimUtils.buildVimPlugin {
    name = "vim-better-whitespace";
    src = pkgs.fetchFromGitHub {
      owner = "xiyaowong";
      repo = "transparent.nvim";
      rev = "f09966923f7e329ceda9d90fe0b7e8042b6bdf31";
      sha256 = "sha256-Z4Icv7c/fK55plk0y/lEsoWDhLc8VixjQyyO6WdTOVw=";
    };
  };
in
[
  nvim-treesitter
  nvim-lspconfig

  onedark-nvim
  # TODO: run "TransparentEnable" in config somewhere
  transparent

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
