{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.xdg-desktop-portal-hyprland = {
    enable = true;
  };
}
