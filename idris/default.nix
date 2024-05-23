{pkgs, ...}: {
  imports = [
    ./kernel.nix
    ./idris-hardware.nix
    ./configuration.nix
    ./bluetooth.nix
  ];
  environment.systemPackages = [
    pkgs.valgrind
    pkgs.gdb
    pkgs.swayosd
    pkgs.jellyfin-media-player
  ];
}
