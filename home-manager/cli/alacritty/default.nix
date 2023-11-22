{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./colors.nix
    ./settings.nix
  ];
  programs.alacritty = {
    enable = true;
  };
}
