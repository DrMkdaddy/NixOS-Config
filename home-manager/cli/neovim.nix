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
      lsp = {
	enable = true;
	servers = {
	  nil_ls.enable = true; 
	};
      };
      

      #cmp
      nvim-cmp = {
	sources = [
	  { name = "nvim_lsp"; }
	  { name = "luasnip"; } #For luasnip users.
	  { name = "path"; }
	  { name = "buffer"; }
	];
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
