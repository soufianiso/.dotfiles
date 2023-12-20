" Plugins:
call plug#begin()
Plug 'https://github.com/tpope/vim-sleuth'
Plug 'https://github.com/lukas-reineke/indent-blankline.nvim'
Plug 'https://github.com/rafamadriz/friendly-snippets'
Plug 'https://github.com/L3MON4D3/LuaSnip'
Plug 'https://github.com/nathom/tmux.nvim'
Plug 'https://github.com/debugloop/telescope-undo.nvim'
Plug 'https://github.com/anuvyklack/pretty-fold.nvim'
Plug 'https://github.com/machakann/vim-highlightedyank'
Plug 'https://github.com/navarasu/onedark.nvim'
Plug 'https://github.com/catppuccin/vim', { 'as': 'catppuccin' }
Plug 'https://github.com/ThePrimeagen/harpoon'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/williamboman/mason.nvim'
Plug 'https://github.com/williamboman/mason-lspconfig.nvim'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/hrsh7th/nvim-cmp'
Plug 'https://github.com/hrsh7th/cmp-buffer'
Plug 'https://github.com/hrsh7th/cmp-path'
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
Plug 'https://github.com/hrsh7th/cmp-nvim-lua'
Plug 'https://github.com/saadparwaiz1/cmp_luasnip'
Plug 'https://github.com/VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
Plug 'https://github.com/nvim-lualine/lualine.nvim'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/mhinz/vim-signify'
Plug 'https://github.com/jamespwilliams/bat.vim'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/scrooloose/nerdtree-project-plugin'
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-telescope/telescope.nvim'
Plug 'https://github.com/sharkdp/bat'
Plug 'https://github.com/sonph/onehalf'
Plug 'https://github.com/mattn/emmet-vim.git'
call plug#end()

" Some Settings:

set number
set relativenumber
let g:highlightedyank_highlight_duration = 200 
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
set termguicolors
set clipboard=unnamedplus
set cursorline

"
" Some Mappings:

let mapleader = " "
map      <leader>' ysiw'<CR>
map      <leader>" ysiw"<CR>
map      <leader>) ysiw)<CR>
map      <leader>} ysiw}<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <c-w> <cmd>vsplit<CR>
nnoremap <leader>p <cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>1 <cmd>lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>2 <cmd>lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>3 <cmd>lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>4 <cmd>lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>5 <cmd>lua require("harpoon.ui").nav_file(5)<CR>
nnoremap <leader>6 <cmd>lua require("harpoon.ui").nav_file(6)<CR>
nnoremap <leader>a <cmd>lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>h <cmd>noh<CR>
noremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
" Use ctrl-[hjkl] to select the active split!
  
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

nmap <leader>u <cmd>Telescope undo<CR>
nmap <leader>g <cmd>Telescope live_grep<CR>
colorscheme gruvbox

" LUA CONFIG
lua << END

-- LuaLine Plugin
require('lualine').setup {
  options = {
    icons_enabled = false,
	theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {''},
    lualine_b = {'', '', 'filename'},
    lualine_c = {''},
    lualine_x = {'', '', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {''}
  },
}


-- [LSP Configuration]
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)



-- [Mason configuration]
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})


-- [Autocompletion configuration]
local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format()
local cmp_action = require('lsp-zero').cmp_action()
require('luasnip.loaders.from_vscode').lazy_load()
cmp.setup({
	 mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		['<C-y>'] = cmp.mapping.confirm({select = true}),
		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),
		-- Navigate between snippet placeholder
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),
		-- Scroll up and down in the completion documentation
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
	  }),
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'path'},
    {name = 'buffer'},
  },
  formatting = cmp_format,
})


-- [treesitter Configuration]

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {"bash","rust" ,"go", "python", "c", "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,
  indent = { enable = true},
  ignore_install = { "javascript" },
  highlight = {
    enable = false,

    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  },
}

require('onedark').setup{
	-- Lua
require('onedark').setup{
    -- Main options --
	priority = 1000,
    style = 'warmer', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = false, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'bold',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
}
-- require('onedark').load()
-- require("ibl").setup()
--mapping: -------
vim.o.completeopt = 'menuone,noselect'
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv",{silent=true})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv",{silent=true})
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>i", ":PlugInstall<CR>", {silent=true})
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)
vim.keymap.set("n", "<leader>z", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.api.nvim_set_keymap("n", "<C-p>", ':lua require"telescope.builtin".find_files({hidden = true})<CR>',{noremap = true, silent = true})
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'i' }, '<C-y>', '<Nop>', { silent = true })
END
