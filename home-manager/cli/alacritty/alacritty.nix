{lib, ...}: 
{
  programs.alacritty = {
    enable = true;
    settings = lib.attrsets.recursiveUpdate (import ../../program/terminal/alacritty/default-settings.nix) {
      shell.program = "/usr/local/bin/fish";
    };
  };
}
