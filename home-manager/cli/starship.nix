{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
  };
}
