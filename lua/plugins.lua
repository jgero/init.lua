-- Install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
    vim.cmd([[packadd packer.nvim]])
end
require('packer').startup(function(use)
    -- Package manager
    use('wbthomason/packer.nvim')
    -- highlighting
    use('nvim-treesitter/nvim-treesitter')
    -- color theme
    use('navarasu/onedark.nvim')
    -- lsp
    use('neovim/nvim-lspconfig')
    use('folke/neodev.nvim') -- make vim api available for sumneko_lua server
    use('https://git.sr.ht/~whynothugo/lsp_lines.nvim') -- pretty diagnostics
    -- completion menu
    use('hrsh7th/nvim-cmp')
    -- completion sources
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')
    use('ray-x/cmp-treesitter')
    -- snippets
    use('l3mon4d3/luasnip')
    use('saadparwaiz1/cmp_luasnip')
    use('rafamadriz/friendly-snippets')
    -- commenting
    use('numToStr/Comment.nvim')
    use('JoosepAlviste/nvim-ts-context-commentstring')
    -- navigation
    use({
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' },
    })
    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable('make') == 1,
    })
    -- TODO: harpoon
    -- git and history
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use({ 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } })
end)
