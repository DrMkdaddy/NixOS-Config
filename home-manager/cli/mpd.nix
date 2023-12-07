{pkgs, ...}: {
  services.mpd = {
    enable = true;
    musicDirectory = /home/noor/Soulseek/Music;
  };
}
