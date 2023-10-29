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
  ];
  systemd.user.startServices = "sd-switch";
  users.defaultUserShell = pkgs.fish;
  home = {
    username = "noor";
    homeDirectory = "/home/noor";
  };
  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
  home.stateVersion = "22.05";
}
