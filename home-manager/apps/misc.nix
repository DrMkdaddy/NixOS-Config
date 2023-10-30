{pkgs, ...}: {
  home.packages = with pkgs; [
    armcord
    bottles
    obsidian
  ];
}
