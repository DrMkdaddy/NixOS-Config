{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  time.timeZone = "America/Los_Angeles";
  enviroment.sessionVariables = {EDITOR = "${pkgs.nvim}/bin/nvim";};
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      (vaapiIntel.override {enableHybridCodec = true;})
      vaapiVdpau
      libvdpau-va-gl
    ];
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk inputs.xdph.packages.${pkgs.system}];
      config.common.default = "*";
    };
    nix = {
      registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

      settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        trusted-users = ["root" "@wheel"];
      };
    };
    programs = {
      dconf.enable = true;
      fish.enable = true;
    };
    services = {
      flatpak.enable = true;
      system76-scheduler.settings.cfsProfiles.enable = true;
      thermald.enable = true;
      pipewire = {
        enable = true;
        wireplumber.enable = true;
        pulse.enable = true;
        jack.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
      };
      tlp = {enable = true;};
    };
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
