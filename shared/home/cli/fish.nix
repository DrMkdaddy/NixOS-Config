{pkgs, ...}: {
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.fish = {
    enable = true;
    shellInit = ''
      nix-your-shell fish | source
      source (starship init fish --print-full-init | psub)
      zoxide init fish | source
      set -x DIRENV_LOG_FORMAT ""
      set fish_greeting
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
