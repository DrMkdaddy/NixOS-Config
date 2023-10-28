{pkgs, ...}: {
  home.packages = with pkgs; [
    armcord
    steam
  ];
}
