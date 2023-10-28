{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellInit = ''
      source (starship init fish --print-full-init | psub)
      zoxide init fish | source
    '';
  };
}
