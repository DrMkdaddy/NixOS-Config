{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellInit = ''
      source (starship init fish --print-full-init | psub)
      zoxide init fish | source
    '';
    shellAbbrs = {
      nxrb = "sudo nixos-rebuild switch --flake /home/noor/Sysflake/";
      hmrb = "home-manager switch --flake /home/noor/Sysflake/";
      ls = "eza --icons=always -l";
      v = "nvim";
    };
  };
}
