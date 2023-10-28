{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.element-desktop-wayland = {
    enable = true;
  };
}
