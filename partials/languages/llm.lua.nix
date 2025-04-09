{ pkgs, ... }: ''
  require("llm").setup({
    lsp = {
      bin_path = "${pkgs.llm-ls}/bin/llm-ls"
    }
  })
''
