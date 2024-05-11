{pkgs, ...}: {
  imports = [
    ./kernel.nix
    ./idris-hardware.nix
    ./configuration.nix
    ./zerotier.nix
    ./bluetooth.nix
    ./greetd.nix
  ];
  environment.systemPackages = [
    pkgs.valgrind
    pkgs.gdb
  ];
}
