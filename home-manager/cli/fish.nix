{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellInit = ''
      source (starship init fish --print-full-init | psub)
      zoxide init fish | source
      set -x DIRENV_LOG_FORMAT ""
    '';
    shellAbbrs = {
      nxrb = "sudo nixos-rebuild switch --flake /home/noor/Sysflake/";
      hmrb = "home-manager switch --flake /home/noor/Sysflake/";
      ls = "eza --icons=always -1";
      v = "nvim";
      flake = "nix flake";
      f = "cd /home/noor/Sysflake/";
    };
  };
}
