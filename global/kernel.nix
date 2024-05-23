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
    kernelParams = lib.mkMerge [
      ["quiet" "splash"]
      (lib.mkIf (host == "nasr") ["nvidia-drm.fbdev=1"])
    ];
  };
}
