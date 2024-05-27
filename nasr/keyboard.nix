{pkgs, ...}: {
  boot.kernelModules = ["i2c-dev" "i2c-piix4"];

  hardware.keyboard.qmk.enable = true;
  environment.systemPackages = [pkgs.via];
  services = {
    hardware.openrgb.enable = true;
    udev = {
      packages = with pkgs; [via openrgb];
    };
  };
}
