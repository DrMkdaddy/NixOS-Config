{
  pkgs,
  config,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    extraModulePackages = with config.boot.kernelPackages; [];
    kernelParams = ["quiet" "splash" "nvidia-drm.fbdev=1"];
  };
}
