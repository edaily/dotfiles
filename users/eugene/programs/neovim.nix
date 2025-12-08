{ inputs, config, lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Color scheme
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        transparent_background = true;
        flavour = "mocha";
      };
    };

    opts = {
      number = false;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      breakindent = true;

      # Search
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;

      # UI
      termguicolors = true;
      signcolumn = "yes";
      cursorline = true;
      scrolloff = 8;
      sidescrolloff = 8;
      mouse = "a";

      # Splits
      splitbelow = true;
      splitright = true;

      # Files
      undofile = true;
      backup = false;
      swapfile = false;

      # Performance
      updatetime = 250;
      timeoutlen = 300;
    };

    # Global settings
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    # Plugins
    plugins = {
      # Statusline
      lualine = { enable = true; };

      # Web dev icons (required by neo-tree, telescope, bufferline)
      web-devicons = { enable = true; };

      # File explorer
      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = true;
          window = { width = 30; };
        };
      };

      # Fuzzy finder
      telescope = {
        enable = true;
        extensions = { fzf-native = { enable = true; }; };
      };

      # Treesitter for syntax highlighting
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # Auto-completion
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
          sources = [ { name = "nvim_lsp"; } { name = "luasnip"; } { name = "path"; } { name = "buffer"; } ];
        };
      };

      # Snippets
      luasnip = { enable = true; };

      # LSP
      lsp = {
        enable = true;
        servers = {
          # Nix
          nil_ls = { enable = true; };

          # Go
          gopls = { enable = true; };

          # Lua
          lua_ls = { enable = true; };

          # TypeScript
          ts_ls = { enable = true; };
        };
      };

      # Auto-pairs
      nvim-autopairs = { enable = true; };

      # Git integration
      gitsigns = {
        enable = true;
        settings = { current_line_blame = true; };
      };

      # Comment
      comment = { enable = true; };

      # Which-key for keybinding hints
      which-key = { enable = true; };

      # Indent guides
      indent-blankline = { enable = true; };

      # Buffer line
      bufferline = { enable = true; };
    };

    # Extra configuration using Lua
    extraConfigLua = ''
      -- Keymaps
      local map = vim.keymap.set

      -- Clear search highlights
      map('n', '<Esc>', '<cmd>nohlsearch<CR>')

      -- Better window navigation
      map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
      map('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
      map('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
      map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

      -- Buffer navigation
      map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
      map('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })

      -- Move lines up/down
      map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
      map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

      -- Stay in visual mode while indenting
      map('v', '<', '<gv')
      map('v', '>', '>gv')

      -- File explorer
      map('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle file explorer' })

      -- Telescope
      map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
      map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Live grep' })
      map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'Find buffers' })
      map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'Find help' })

      -- LSP keymaps
      map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
      map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
      map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
      map('n', 'gr', vim.lsp.buf.references, { desc = 'Show references' })
      map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
      map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
      map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
      map('n', '<leader>j', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
      map('n', '<leader>k', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })

      -- Highlight yanked text
      vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
          vim.highlight.on_yank({ timeout = 200 })
        end,
      })
    '';
  };
}
