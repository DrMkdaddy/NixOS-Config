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
    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
    ];
  };
}
