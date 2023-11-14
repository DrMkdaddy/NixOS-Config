{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    dunst
    pavucontrol
    swww
  ];
}
