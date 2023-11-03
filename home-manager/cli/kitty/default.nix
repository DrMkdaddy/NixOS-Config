{pkgs, ...}:
{
  programs.kitty = {
    enable = true; 
    extraConfig = builtins.readFile./kitty.conf + builtins.readFile./Monokai_Pro_(Filter_Octagon).conf;
    
  };
}
