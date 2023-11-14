{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.librewolf = {
    enable = true;
  };
}
