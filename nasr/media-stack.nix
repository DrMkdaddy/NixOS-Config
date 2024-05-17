{
  pkgs,
  lib,
  ...
}: {
  imports = [./qbitorrent_module.nix];
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
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    jellyfin-media-player
  ];

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
