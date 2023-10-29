{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs.cinnamon.nemo-with-extensions = {
    enable = true;
  };
}

