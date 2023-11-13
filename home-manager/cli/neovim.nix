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
      lsp = {
        enable = true;
        lsplines.enable = true;
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
