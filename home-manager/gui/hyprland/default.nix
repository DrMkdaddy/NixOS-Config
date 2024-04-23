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
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
    ];
  };
}
