{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
  };
}
