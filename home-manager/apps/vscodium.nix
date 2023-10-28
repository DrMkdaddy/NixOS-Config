{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.vscodium = {
    enable = true;
  };
}
