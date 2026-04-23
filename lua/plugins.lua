local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Colorschemes
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  { "Mofiqul/dracula.nvim", priority = 1000 },
  { "folke/tokyonight.nvim", priority = 1000 },
  { "shaunsingh/nord.nvim", priority = 1000 },
  { "rebelot/kanagawa.nvim", priority = 1000 },
  { "neanias/everforest-nvim", priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- LSP & Completion
  {
    "onsails/lspkind.nvim",
    event = { "VimEnter" },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      require("config.nvim-cmp")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
  },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  { "b0o/schemastore.nvim" },

  -- File Tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },

  -- UI Enhancements
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("config.dashboard")
    end,
  },

    -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup {
            defaults = {
                preview = {
                    treesitter = false,
                },
            },
        }
    end,
},

{
    --Treesitter
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.config").setup {
            ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "javascript" },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        }
    end,
},

  --Lualine
  {
"nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup {
      options = {
        theme = "auto",
      },
    }
  end,
},

    --Claude Code
{
    "greggh/claude-code.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("claude-code").setup()
    end,
},

})

