{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian
    gamescope
    thunderbird
    element-desktop
    prismlauncher
    mpv
    chromium
    nicotine-plus
  ];
}
