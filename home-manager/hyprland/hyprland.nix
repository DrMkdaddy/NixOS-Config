{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.pavucontrol = {
    enable = true;
  };
}
