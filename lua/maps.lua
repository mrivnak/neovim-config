-- Set leader key
vim.g.mapleader = ","

-- Quick exit insert mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Sane exit terminal mode
vim.keymap.set("t", "jj", "<C-\\><C-N>", { noremap = true, silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { noremap = true, silent = true })

-- nvim-tree
vim.keymap.set("n", "<leader>ft", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ff", "<Cmd>NvimTreeFocus<CR>", { noremap = true, silent = true })

-- barbar
vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { noremap = true, silent = true })

-- Telescope
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Toggleterm
vim.keymap.set("n", "<leader>t", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })

-- nvim-comment
vim.keymap.set({"n", "v"}, "<leader>cc", "<Cmd>CommentToggle<CR>", { noremap = true, silent = true })

