{pkgs, ...}: {
  enviroment.systemPackaes = with pkgs; [
    qbittorrent-nox
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
  services = rec {
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    radarr = jellyfin;
    prowlarr = jellyfin;
    sonarr = jellyfin;
  };
}
