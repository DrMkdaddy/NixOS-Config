{pkgs, ...}: {
  home.packages = with pkgs; [
    dunst
    pavucontrol
    wofi
  ];
}
