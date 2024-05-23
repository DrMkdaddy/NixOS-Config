{
  pkgs,
  config,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages;
    extraModulePackages = with config.boot.kernelPackages; [];
    kernelParams = ["quiet" "splash" "usbcore.autosuspend=-1"];
  };
}
