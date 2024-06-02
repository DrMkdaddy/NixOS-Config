{pkgs, ...}: {
  imports = [
    ./idris-hardware.nix
    ./configuration.nix
    ./bluetooth.nix
  ];
  environment.systemPackages = with pkgs; [
    valgrind
    gdb
    swayosd
    jellyfin-media-player
    qownnotes
    nextcloud-client
  ];
}
