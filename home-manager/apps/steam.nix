{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.steam = {
    enable = true;
  };
}
