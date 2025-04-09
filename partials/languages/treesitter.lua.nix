{pkgs, ...}: ''
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
	},
	ensure_installed = {},
	auto_install = false,
  #parser_install_dir = "${pkgs.vimPlugins.nvim-treesitter.withAllGrammars}/parser",
	-- context commetstring setup
	-- source: https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
''
