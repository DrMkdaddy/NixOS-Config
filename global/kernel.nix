{
  pkgs,
  config,
  lib,
  host,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    extraModulePackages = with config.boot.kernelPackages; [];
    kernelParams = ["quiet" "splash"] ++ lib.optionals (host == "nasr") ["nvidia-drm.fbdev=1"];
  };
}
