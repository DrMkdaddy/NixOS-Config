{pkgs, ...}: {
  hardware.keyboard.qmk.enable = true;
  environment.systemPackages = [pkgs.via];
  services = {
    openrgb.enable = true;
    udev.packages = [pkgs.via];
  };
}
