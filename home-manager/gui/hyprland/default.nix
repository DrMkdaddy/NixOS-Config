{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./config.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprwinwrap
    ];
  };
}
