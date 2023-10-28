{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.steam = {
    enable = true;
  };
}
