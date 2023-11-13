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

      autocomplete.enable = true;
      autopairs.enable = true;
      telescope.enable = true;


      
      statusline.lualine = {
        enable = true;
      };

      lsp = {
        enable = true;
        lsplines.enable = true;
        nvim-docs-view.enable = true;
      };

      filetree.nvimTree = {
        enable = true;
      };

      theme = {
        enable = true;
        name = "tokyonight";
        style = "moon";
      };

      treesitter = {
        enable = true; 
        grammars = [
        ];
      };

      presence.presence-nvim = {
        enable = true;
        enable_line_number = true;
      };

      ui = {
        breadcrumbs = {
          navbuddy.enable = true;
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
        elixir.enable =true;
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
