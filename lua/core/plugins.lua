local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- Theme
  use { "catppuccin/nvim", as = "catppuccin" }

  -- File explorer + icons
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'

  -- Status line
  use 'nvim-lualine/lualine.nvim'

  -- Treesitter for better syntax
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Telescope fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  ----------------------------------------------------------------
  -- 💡 Completion + Snippets + LSP
  ----------------------------------------------------------------

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<CR>']  = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end
  }

  -- LSP config
  use {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      -- Enable servers you need here
      lspconfig.clangd.setup {}    -- for C/C++
      lspconfig.pyright.setup {}   -- for Python
      -- lspconfig.tsserver.setup {} -- JavaScript/TypeScript
    end
  }

  -- Snippets
  use 'L3MON4D3/LuaSnip'

  ----------------------------------------------------------------

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
