{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.dunst = {
    enable = true;
  };
}
