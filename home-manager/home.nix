{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./hyprland
    ./cli
    ./apps
  ];
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = true;
  };
  home.packages = with pkgs; [
    nerdfonts # stay
    waybar # hyprland
    dunst # hyprland
    pavucontrol #hyprland folder maybe
    xdg-desktop-portal-hyprland #hyprland
  ];
  systemd.user.startServices = "sd-switch";
  home = {
    username = "noor";
    homeDirectory = "/home/noor";
  };
  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
  home.stateVersion = "22.05";
}
