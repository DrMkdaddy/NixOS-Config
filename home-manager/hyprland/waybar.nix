{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.waybar = {
    enable = true;
  };
}
