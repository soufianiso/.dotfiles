call plug#begin()
Plug 'psliwka/vim-smoothie',
Plug 'j-hui/fidget.nvim',
Plug 'folke/zen-mode.nvim',
Plug 'nvim-telescope/telescope.nvim'  
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ThePrimeagen/harpoon'
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'L3MON4D3/LuaSnip'
Plug 'nathom/tmux.nvim'
Plug 'anuvyklack/pretty-fold.nvim'
Plug 'machakann/vim-highlightedyank'
Plug 'navarasu/onedark.nvim'
Plug 'eddyekofo94/gruvbox-flat.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'nvim-lua/plenary.nvim'
Plug 'sonph/onehalf'
call plug#end()

" Some Settings:

set number
set relativenumber
let g:highlightedyank_highlight_duration = 100 
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus
set termguicolors
set clipboard=unnamedplus
set cursorline
set noswapfile
let mapleader = " "
map      <leader>' ysiw'<CR>
map      <leader>" ysiw"<CR>
map      <leader>) ysiw)<CR>
map <c-f> <Nop>
map      <leader>} ysiw}<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <c-w> <cmd>vsplit<CR>
nnoremap <leader>h <cmd>noh<CR>
noremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <C-D> <cmd>call smoothie#do("\<C-D>zz") <CR>
nnoremap <silent> <C-u> <cmd>call smoothie#do("\<C-u>zz") <CR>
vnoremap <silent> <C-D> <cmd>call smoothie#do("\<C-D>zz") <CR> 
vnoremap <silent> <C-u> <cmd>call smoothie#do("\<C-u>zz") <CR> 

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" nnoremap <silent> <C-d> :call smoothie#do("\<C-D>zz0")<CR>
" nnoremap <silent> <C-f> :call smoothie#do("\<C-f>zz0")<CR>
" colorscheme catppuccin-mocha " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
nnoremap <silent> <C-p> :Telescope git_files<CR>
" Some Mappings:

" LUA CONFIG
lua << END
vim.o.textwidth = 80
vim.o.wrap = true
vim.wo.signcolumn = 'yes'
vim.o.breakindent = true
vim.g.gruvbox_telescope = false 
vim.g.gruvbox_flat_style = "hard"
vim.g.gruvbox_italic_comments = false
vim.g.gruvbox_italic_keywords = false
vim.cmd[[colorscheme gruvbox-flat]]
-- LuaLine Plugin:
require('lualine').setup {
  options = {
    icons_enabled = false,
	theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {''},
	lualine_c = {{'filename',path=1}},
    lualine_b = {'', '', ''},
    lualine_x = {'branch', 'diff', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {''}
  },
}
require("fidget").setup {
  -- options
}

-- [LSP Configuration]
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
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
		['<C-y>'] = cmp.mapping.confirm {
			  behavior = cmp.ConfirmBehavior.Replace,
			  select = true,
		},
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
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-Space>",
			node_incremental = "<C-Space>",
			scope_incremental = "<C-s>",
			node_decremental = "<C-x>",
		},
	},

    highlight = {
        enable = true
        },

  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
                   ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
            ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
            ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

            ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
            ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

            ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

            ["ao"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
            ["io"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

            ["af"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
            ["if"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

            ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },-- You can use the capture groups defined in textobjects.scm
		
      },
		
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
      goto_next = {
        [']i'] = "@conditional.inner",
      },
      goto_previous = {
        ['[i'] = "@conditional.inner",
      }
    },
    
  },
}
local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

	
-- [indent-blankline Configuration]
require("ibl").setup()
--mapping: -------
vim.o.completeopt = 'menuone,noselect'
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv",{silent=true})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv",{silent=true})
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
vim.keymap.set("n", "J", "mzJ`z")
--vim.keymap.set("n", "<C-d>", "<C-d>zz")
--vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>i", ":PlugInstall<CR>", {silent=true})
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so%") end)
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-t>', '<Nop>', { silent = true })
vim.keymap.set({"n"} , '<leader>g', ':Git<cr>', { silent = false })
vim.keymap.set( 'i' , '<C-y>', '<Nop>', { silent = true })


-- harpoon Configuration
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
	vim.keymap.set("n", "<leader>a", mark.add_file)
	vim.keymap.set("n", "<leader>p", ui.toggle_quick_menu)
	vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
	vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
	vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
	vim.keymap.set("n", "<leader>4" , function() ui.nav_file(4) end)
	vim.keymap.set("n", "<leader>5" , function() ui.nav_file(5) end)
	vim.keymap.set("n", "<leader>6" , function() ui.nav_file(6) end)

-- worktree Configuration--
vim.keymap.set('n', '<leader>gw',':Telescope git_worktree<cr>' , {})
vim.keymap.set('n', '<leader>gc',":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>" , {})
require("telescope").load_extension('fzf')
require("telescope").load_extension('harpoon')
require("telescope").load_extension("git_worktree")

require('telescope').setup{
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
      prompt_position = 'top',
      horizontal = {
        results_width = 1,  -- Adjust this value as needed
      },
      height = 0.8,  -- Adjust this value as needed
      width = 0.8,   -- Adjust this value as needed
      preview_cutoff = 120,
    },
    sorting_strategy = 'ascending',
  }
}



local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<c-f>', builtin.find_files)
	vim.keymap.set('n', '<c-g>', function() builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").setup {
        window = {
            width = 140,
            options = {}
        },
		plugins = {
		      tmux = {enabled = true},
			alacritty = {
			  enabled = true,
			  font = "10", -- font size
			},
				
			  
		}
    }
    require("zen-mode").toggle()
    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.rnu = true
end)

END
