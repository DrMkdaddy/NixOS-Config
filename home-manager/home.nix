{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
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
    font-awesome
    powerline-fonts
    rounded-mgenplus
  ];
  systemd.user.startServices = "sd-switch";
  home = {
    stateVersion = "22.05";
    username = "noor";
    homeDirectory = "/home/noor";
  };
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = true;
  };
  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
}
