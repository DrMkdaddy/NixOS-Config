{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellInit = ''
      source (starship init fish --print-full-init | psub)
      zoxide init fish | source
      abbr -a nxrb "sudo nixos-rebuild switch --flake /home/noor/Sysflake/"
      abbr -a hmrb "home-manager switch --flake /home/noor/Sysflake/"
    '';
  };
}
