{
  pkgs,
  inputs,
  lib,
  ...
}: {
    home.packages = with pkgs; [
    (firefox.override { extraNativeMessagingHosts = [ inputs.pipewire-screenaudio.packages.${pkgs.system}.default ]; })
    # ...
  ];
}
