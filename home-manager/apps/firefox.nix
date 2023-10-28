{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.firefox = {
    enable = true;
  };
}
