{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.neovim-flake.homeManagerModules.default];
  programs.neovim-flake = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      leaderKey = ";";
      useSystemClipboard = true;

      autopairs.enable = true;
      telescope.enable = true;
      tabline.nvimBufferline.enable = true;
      comments.comment-nvim.enable = true;
      dashboard.alpha.enable = true;
      filetree.nvimTree.enable = true;
      notify.nvim-notify.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
      };

      statusline.lualine = {
        enable = true;
      };

      notes = {
        todo-comments.enable = true;
        obsidian = {
          enable = true;
        };
        orgmode = {
          enable = true;
          treesitter.enable = true;
        };
      };

      lsp = {
        enable = true;
        lsplines.enable = true;
        lspsaga.enable = true;
        nvim-docs-view.enable = true;
        formatOnSave = true;
        lspkind.enable = true;
      };

      theme = {
        enable = true;
        name = "tokyonight";
        style = "moon";
      };

      treesitter = {
        enable = true;
        fold = true;
        context = {
          enable = true;
        };
        grammars = [];
      };

      autocomplete = {
        enable = true;
        mappings = {
          complete = "<C-Space>";
        };
      };

      presence.presence-nvim = {
        enable = true;
        enable_line_number = true;
      };

      utility = {
        icon-picker.enable = true;
      };

      visuals = {
        scrollBar.enable = true;
        nvimWebDevicons.enable = true;
        indentBlankline = {
          enable = true;
          eolChar = "EOL";
          fillChar = "";
          listChar = ".";
        };
        smoothScroll.enable = true;
        cursorline.enable = true;
      };

      ui = {
        illuminate.enable = true;
        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };
        colorizer = {
          options = {
            css = true;
            css_fn = true;
            hsl_fn = true;
            rgb_fn = true;
            rrggbbaa = true;
          };
        };
        smartcolumn = {
          enable = true;
          columnAt.languages = {
            nix = 100;
            python = 120;
            lua = 100;
            elixir = 120;
            rust = 100;
          };
        };
      };

      terminal = {
        toggleterm = {
          enable = true;
          enable_winbar = true;
          lazygit.enable = true;
          mappings = {
            open = "<leader>m";
          };
        };
      };

      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        # Languages to Enable
        elixir.enable = true;
        html.enable = true;
        lua.enable = true;
        markdown.enable = true;
        nix.enable = true;
        python.enable = true;
        rust = {
          enable = true;
          crates.enable = true;
        };
      };
    };
  };
}
