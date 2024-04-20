{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware/laptop-hardware.nix
    ./hardware/laptop
    ./kernel.nix
    ./zerotier.nix
    ./apps
    ./greetd.nix
    ./ssh.nix
  ];
  time.timeZone = "America/Los_Angeles";
  nixpkgs = {
    config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
    };
    config.allowUnfree = true;
  };
  environment.sessionVariables = {
    EDITOR = "/home/noor/.nix-profile/bin/nvim";
  };
  environment.systemPackages = [
  ];
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      inputs.xdph.packages.x86_64-linux.xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };
  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };
  programs.dconf.enable = true;
  services.flatpak.enable = true;
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
    };
  };
  boot.loader.systemd-boot.enable = true;
  users.users = {
    noor = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = ["wheel" "networkmanager" "noor"];
      useDefaultShell = true;
      # hashedPassword = "$6$h96Ka8kYUksTQ/M7$Hi9DFYLtyJqea2hDrHqY.PBdugzB0GIzY4hDVrjC0ePpsuj133k3KfhuDpuyucfZVkPkEM/SZMtQbqb3qeTtL.";
      initialPassword = "";
    };
  };
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.system76-scheduler.settings.cfsProfiles.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  services.power-profiles-daemon.enable = false;
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;
  system.stateVersion = "23.05";
}
