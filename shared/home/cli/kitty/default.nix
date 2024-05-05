{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    extraConfig = ''
      include ${./kitty.conf}
      include ${./tokyo-night-kitty.conf}
    '';
  };
}
