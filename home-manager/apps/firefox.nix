{
  pkgs,
  inputs,
  lib,
  nixpkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
  };
}
