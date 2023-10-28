{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.starship = {
    enable = true;
  };
}
