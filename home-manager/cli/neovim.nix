{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
