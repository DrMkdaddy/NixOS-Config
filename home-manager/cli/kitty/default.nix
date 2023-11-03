{pkgs, ...}:
{
  programs.kitty = {
    enable = true; 
    extraConfig ='' 
     include ${./kitty.conf}
     include ${./theme.conf}
    '';
  };
}
