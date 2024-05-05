{
  pkgs,
  config,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_lqx;
    extraModulePackages = with config.boot.kernelPackages; [];
    kernelParams = ["quiet" "splash"];
  };
}
