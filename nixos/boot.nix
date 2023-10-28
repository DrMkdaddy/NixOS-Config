{
  config,
  lib,
  pkgs,
  ...
}: let
  nixos-boot-src = pkgs.fetchFromGitHub {
    owner = "Melkor333";
    repo = "nixos-boot";
    rev = "main";
    sha256 = "sha256-kcYd39n58MVI2mFn/PSh5O/Wzr15kEYWgszMRtSQ+1w=";
  };
  nixos-boot = pkgs.callPackage nixos-boot-src {};
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
