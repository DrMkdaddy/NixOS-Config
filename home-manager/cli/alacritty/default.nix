{
  pkgs,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = lib.attrsets.recursiveUpdate (import ./settings.nix) {
      shell.program = "${pkgs.fish}/bin/fish";
    };
  };
}
