{pkgs, ...}: {
  imports = [
    ./idris-hardware.nix
    ./configuration.nix
    ./kernel.nix
    ./zerotier.nix
    ./bluetooth.nix
  ];
  environment.systemPackages = [
    pkgs.valgrind
    pkgs.gdb
  ];
}
