{pkgs, ...}: let
  openrgb-rules = builtins.fetchurl {
    url = "https://gitlab.com/CalcProgrammer1/OpenRGB/-/jobs/artifacts/master/raw/60-openrgb.rules?job=Linux+64+AppImage";
    sha256 = "sha256:1csqydwgnjdgm5niqyzai6nqvpqi94lq4q483qb464lf69ybnp83";
  };
in {
  boot.kernelModules = ["i2c-dev" "i2c-piix4"];

  hardware.keyboard.qmk.enable = true;
  environment.systemPackages = [pkgs.via];
  services = {
    hardware.openrgb.enable = true;
    udev = {
      extraRules = builtins.readFile openrgb-rules;
      packages = [pkgs.via];
    };
  };
}
