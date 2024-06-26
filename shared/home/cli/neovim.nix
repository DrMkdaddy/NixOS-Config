{inputs, ...}: {
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
      notify.nvim-notify.enable = true;
      enableLuaLoader = true;

      git = {
        enable = true;
        gitsigns.enable = true;
      };

      statusline.lualine = {
        enable = true;
      };

      binds = {
        cheatsheet.enable = true;
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

      utility = {
        icon-picker.enable = true;
      };

      visuals = {
        enable = true;
        scrollBar.enable = true;
        nvimWebDevicons.enable = true;
        indentBlankline = {
          scope = {
            enabled = true;
          };
          enable = true;
          eolChar = " ";
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
          enable = true;
          setupOpts.user_default_options = {
            css = true;
          };
        };
      };

      terminal.toggleterm = {
        enable = true;
        setupOpts.enable_winbar = true;
        lazygit.enable = true;
        mappings = {
          open = "<leader>m";
        };
      };

      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        # Languages to Enable
        rust = {
          enable = true;
          crates.enable = true;
        };
        python = {
          enable = true;
          lsp.enable = true;
          format.enable = true;
        };
        nix = {
          enable = true;
        };
        elixir.enable = true;
        html.enable = true;
        lua.enable = true;
        css.enable = true;
        markdown.enable = true;
      };
    };
  };
}
