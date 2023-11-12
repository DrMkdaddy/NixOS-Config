{pkgs, ...}: {
  home.packages = with pkgs; [
    armcord
    obsidian
    (discord.override {withOpenASAR = true; withVencord = true;})
    gamescope
    thunderbird
    element-desktop
    prismlauncher
    mpv
  ];
}
