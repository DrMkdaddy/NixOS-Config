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

      autopairs.enable = true;
      visuals.nvimWebDevicons.enable = true;
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

      ui = {
        illuminate.enable = true;
        breadcrumbs = {
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
      };

      terminal = {
        toggleterm = {
          enable = true;
          enable_winbar = true;
          lazygit.enable = true;
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
