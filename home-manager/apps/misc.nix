{pkgs, ...}: {
  home.packages = with pkgs; [
    armcord
    obsidian
    (discord.override {withOpenASAR = true; withVencord = true;})
    gamescope
  ];
}
