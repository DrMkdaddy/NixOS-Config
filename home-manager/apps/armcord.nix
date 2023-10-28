{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.armcord = {
    enable = true;
  };
}
