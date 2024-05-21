{
  pkgs,
  lib,
  ...
}: {
  imports = [./qbitorrent_module.nix ./tdarr.nix];
  users.users."qbittorrent" = {
    isSystemUser = true;
    group = "media";
  };

  users.groups.media = {
    members = [
      "jellyfin"
      "qbittorrent"
      "radarr"
      "bazarr"
      "sonarr"
      "prowlarr"
      "jellyseerr"
    ];
    gid = 1666;
  };
  users.groups.media = {};
  environment.systemPackages = with pkgs; [
    jellyfin-web
    jellyfin-ffmpeg
    jellyfin-media-player
  ];

  networking.firewall.allowedTCPPorts = [5690];
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers."wizarr" = {
    autoStart = true;
    image = "ghcr.io/wizarrrr/wizarr:latest";
    ports = ["5690:5690"];
    volumes = ["/home/noor/wizarr:/data/database"];
  };

  services = rec {
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    radarr = jellyfin;
    prowlarr = jellyfin;
    sonarr = radarr;
    bazarr = radarr;
    jellyseerr = jellyfin;
    qbittorrent = lib.mkMerge [
      jellyfin
      {
        group = "media";
        dataDir = "/mnt/nuclearmissilesilo/qbittorrent_dls";
        port = 5080;
      }
    ];
  };
}
