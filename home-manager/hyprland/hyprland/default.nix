{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.hyprland.homeManagerModules.default];
  home.packages = [
    inputs.hyprpicker
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprwinwrap
    ];
  };
}
