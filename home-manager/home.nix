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
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "FiraCode"
        "CascadiaCode"
      ];
    })
    fira-go
    noto-fonts
    noto-fonts-emoji
    corefonts
    lmodern
  ];
  systemd.user.startServices = "sd-switch";
  home = {
    stateVersion = "22.05";
    username = "noor";
    homeDirectory = "/home/noor";
  };
  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
}
