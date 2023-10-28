{
  config,
  lib,
  pkgs,
  ...
}: let
  #nixos-boot-src = import ../default.nix;
  # Fetch the repository
  nixos-boot-src = pkgs.fetchFromGitHub {
    owner = "Melkor333";
    repo = "nixos-boot";
    rev = "main";
    sha256 = "sha256-kcYd39n58MVI2mFn/PSh5O/Wzr15kEYWgszMRtSQ+1w=";
  };
  # define the theme you want to use
  nixos-boot = pkgs.callPackage nixos-boot-src {};
  # You might want to override the theme
  #nixos-boot = pkgs.callPackage nixos-boot-src {
  #  bgColor = "0.1, 1, 0.8"; # Weird 0-1 range RGB. In this example roughly mint
  #  theme = "load_unload";
  #};
in {
  boot = {
    loader.systemd-boot.enable = true;
    plymouth = {
      enable = true;
      themePackages = [nixos-boot];
      theme = "load_unload";
    };
  };
  systemd.services.plymouth-quit = {
    preStart = "${pkgs.coreutils}/bin/sleep 3";
  };
}
