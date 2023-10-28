{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.pavucontrol = {
    enable = true;
  };
}
