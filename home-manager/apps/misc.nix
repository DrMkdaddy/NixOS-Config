{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    gamescope
    thunderbird
    element-desktop
    prismlauncher
    mpv
    armcord
    rustdesk
    chromium
    nicotine-plus
  ];
}
