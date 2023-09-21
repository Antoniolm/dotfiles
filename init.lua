--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

--]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-fugitive',
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
    },
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
    },
  },

	{ "j-hui/fidget.nvim",
            tag = "legacy",
            lazy = true,
            event = "LspAttach"
        },
  { 'folke/which-key.nvim', opts = {} },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    }, 
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
    {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
}, {})


vim.cmd[[colorscheme tokyonight]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.opt.tabstop = 4
local fn, g, opt, v = vim.fn, vim.g, vim.opt, vim.v

local options = {
--  Option          = Value,                        -- Description
--------------------------------------------------------------------------------
    autoindent      = true,                         -- Start new lines correctly indented
    breakindent     = true,                         -- Indent wrapped lines' continuations
    cindent         = true,                         -- Indent according to the C indenting rules
    colorcolumn     = {81},                         -- Draw column at line character limit
    completeopt     = { "menuone", "noselect" },    -- Completion engine options
    cursorline      = true,                         -- Highlight the line where the cursor is (see cursorlineopt)
    cursorlineopt   = "number",                     -- Highlight the cursor line number (see cursorline)
    expandtab       = true,                         -- Expand tabs to spaces (see softtabstop)
    fillchars       = { diff = "╱", fold = " " },   -- Interface styling (see listchars)
    fixeol          = true,                         -- Restore EOL at EOF if missing when writing
    foldmethod      = "marker",                     -- Only allow foldings with triple brackets
    guicursor       = { a = "block" },              -- Force cursor to be a block at all times
    foldtext        = "v:lua.fold_string()",        -- Custom folding string
    hidden          = true,                         -- Hide inactive buffers instead of deleting them
    hlsearch        = true,                         -- Highlight all search matches
    inccommand      = "split",                      -- Incrementally show effects of commands, opens split
    incsearch       = true,                         -- Highlight search matches while writing (with hlsearch)
    laststatus      = 3,                            -- Use a global statusline instead of one per window
    linebreak       = true,                         -- Respect WORDS when wrap-breaking lines (see wrap)
    list            = true,                         -- Replace special characters (see listchars)
    listchars       = { tab = "🭱 ", trail = "·"  }, -- Alternate tab: »> (see list)
    mouse           = "nvi",                        -- Allow mouse everywhere except in command line mode
    nrformats       = "unsigned",                   -- Treat all numbers as unsigned with <C-A> and <C-X>
    number          = true,                         -- Number column to the left (used with relativenumber)
    relativenumber  = true,                         -- Show numbers relative to cursor position (see number)
    scrolloff       = 5,                            -- Leave 5 lines above and below cursor
    shiftwidth      = 0,                            -- Force indent spaces to equal to tabstop (see tabstop)
    showcmd         = true,                         -- Show the keys pressed in normal mode until action is run
    showtabline     = 2,                            -- Show the tabline even when just one tab is open
    signcolumn      = "yes",                        -- Always show the sign column beside the number (see number)
    smartindent     = true,                         -- Ident new lines in a smart way (see autoindent)
    smarttab        = true,                         -- Treat spaces as tabs in increments of shiftwidth
    softtabstop     = 0,                            -- Do not insert spaces when pressing tab (see shiftwidth)
    splitbelow      = true,                         -- Open splits below the current window
    splitright      = true,                         -- Open splits right of the current window
    tabstop         = 4,                            -- Number of columns to move when pressing <TAB> (see expandtab)
    timeoutlen      = 500,                          -- Milliseconds to wait before completing a mapped sequence
    updatetime      = 300,                          -- Milliseconds to wait before writing to swap file
    wildignorecase  = true,                         -- Ignore case in filenames browsed by wildmenu
    wrap            = false,                        -- Do not wrap text that reaches the window's width
}

for option, value in pairs(options) do
    opt[option] = value
end

opt.shortmess:append("c")

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })

-- [[ Configure Telescope ]]
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

require("fidget").setup({ text = { spinner = "arc" } })
pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>h', '<c-w>h', { desc = 'Move do the left' })
vim.keymap.set('n', '<leader>l', '<c-w>l', { desc = 'Move do the right' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]resume' })

-- [[ Configure Treesitter ]]
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'python', 'vimdoc', 'vim' },

  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
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
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- [[ Configure LSP ]]
local on_attach = function(_, bufnr)
  
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = '[R]e[n]ame'})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[C]ode [A]ction'})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = '[G]oto [D]efinition'})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = bufnr, desc = '[G]oto [R]eferences'})
  vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, { buffer = bufnr, desc = '[G]oto [I]mplementation'})
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Type [D]efinition'})
  vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { buffer = bufnr, desc = '[D]ocument [S]ymbols'})
  vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { buffer = bufnr, desc = '[W]orkspace [S]ymbols'})

  -- See `:help K` for why this keymap
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover Documentation'})
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation'})

  -- Lesser used LSP functionality
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = '[G]oto [D]eclaration'})
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = '[W]orkspace [A]dd Folder'})
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = '[W]orkspace [R]emove Folder'})
end

local servers = {
  clangd = {
        cmd = { "clangd",
            "--all-scopes-completion",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--limit-results=0",
            "--log=verbose",
            "--malloc-trim",
            "--pch-storage=memory",
            "--suggest-missing-includes",
        },
    },
--  pyright = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- [[ Configure nvim-cmp ]]
local cmp = require 'cmp'
local luasnip = require 'luasnip'
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
