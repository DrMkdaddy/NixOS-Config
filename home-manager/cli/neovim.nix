{
  inputs,
  ...
}: {
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.oxocarbon.enable = true;
    
    plugins = {
      lightline.enable = true;
      chadtree.enable = true;
      treesitter.enable = true;
      nvim-autopairs.enable = true; 
      notify.enable = true;
      barbecue.enable = true; 
      auto-save.enable = true;
      lsp = {
	enable = true;
	servers = {
	  nil_ls.enable = true; 
	};
      };
      lsp-lines.enable = true;
      luasnip.enable = true;
      nvim-colorizer.enable = true; 
      
      #cmp
      nvim-cmp = {
	enable = true; 
	snippet.expand = "luasnip";
	sources = [
	  { name = "nvim_lsp"; }
	  { name = "luasnip"; } #For luasnip users.
	  { name = "path"; }
	  { name = "buffer"; }
	];
	mapping = {
	  "<C-Space>" = "cmp.mapping.complete()";
	  "<C-j>" = "cmp.mapping.scroll_docs(4)";
	  "<C-k>" = "cmp.mapping.scroll_docs(-4)";
	  "<C-l>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
	  "<C-n>" = {
	    action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
              else
                fallback()
              end
            end
          '';

        modes = ["i" "s"];
        };
        "<C-p>" = {
          action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif require("luasnip").expand_or_jumpable() then
                require("luasnip").expand_or_jump()
              else
                fallback()
              end
            end
          '';
	  modes = ["i" "s"];
	  };
	};
      };
      cmp-treesitter.enable = true;
      cmp-vim-lsp.enable = true; 
      cmp-buffer.enable = true;
      cmp-path.enable = true;

      startify = {
	enable = true;
	customHeader = [
  ''⠀ ▄▄▄▄    █    ██  ██ ▄█▀ ██ ▄█▀ ▄▄▄       ██ ▄█▀▓█████ ''
  ''⠀▓█████▄  ██  ▓██▒ ██▄█▒  ██▄█▒ ▒████▄     ██▄█▒ ▓█   ▀ ''
  ''⠀▒██▒ ▄██▓██  ▒██░▓███▄░ ▓███▄░ ▒██  ▀█▄  ▓███▄░ ▒███   ''
  ''⠀▒██░█▀  ▓▓█  ░██░▓██ █▄ ▓██ █▄ ░██▄▄▄▄██ ▓██ █▄ ▒▓█  ▄ ''
  ''⠀░▓█  ▀█▓▒▒█████▓ ▒██▒ █▄▒██▒ █▄ ▓█   ▓██▒▒██▒ █▄░▒████▒''
  ''⠀░▒▓███▀▒░▒▓▒ ▒ ▒ ▒ ▒▒ ▓▒▒ ▒▒ ▓▒ ▒▒   ▓▒█░▒ ▒▒ ▓▒░░ ▒░ ░''
  ''⠀▒░▒   ░ ░░▒░ ░ ░ ░ ░▒ ▒░░ ░▒ ▒░  ▒   ▒▒ ░░ ░▒ ▒░ ░ ░  ░''
  ''⠀ ░    ░  ░░░ ░ ░ ░ ░░ ░ ░ ░░ ░   ░   ▒   ░ ░░ ░    ░   ''
  ''⠀ ░         ░     ░  ░   ░  ░         ░  ░░  ░      ░  ░''
  ''⠀      ░                                                ''
	];
	bookmarks = [
	  "/home/noor/Sysflake/"
	];
    };
  };

    # End of Plugins 
    options = {
      number = true; 
      shiftwidth = 2;
    };
    keymaps = [
      {key = "j"; action = "<cmd>CHADopen<cr>";}
    ];
  };
}
