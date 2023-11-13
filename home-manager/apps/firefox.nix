{
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    (firefox.override {nativeMessagingHosts = [inputs.pipewire-screenaudio.packages.${pkgs.system}.default];})
    # ...
  ];
}
