vim.keymap.set('n', '<leader>+', ':resize +1<cr>', { desc = 'grow current split' })
vim.keymap.set('n', '<leader>-', ':resize -1<cr>', { desc = 'shrink current split' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'copy to clipboard' })
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'copy to clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'paste from clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'paste from clipboard' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'paste from clipboard' })
vim.keymap.set('v', '<leader>P', '"+P', { desc = 'paste from clipboard' })
-- reset search highlight on enter press in normal mode
vim.keymap.set('n', '<CR>', '{ -> v:hlsearch ? ":nohl\\<CR>" : "\\<CR>" }()', { expr = true })
-- exit terminal mode with escape
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
-- open new terminal on the bottom
vim.keymap.set('', '<leader>t', ':split term://bash<cr>')
