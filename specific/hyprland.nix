{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    portalPackage = inputs.xdph.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };
}
