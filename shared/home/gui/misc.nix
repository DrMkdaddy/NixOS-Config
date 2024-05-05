{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    dunst
    pavucontrol
    swww
    inputs.swwwitch.packages."x86_64-linux".swwwitch
  ];
}
