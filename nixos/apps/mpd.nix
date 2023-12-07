{pkgs, ...}: {
  services.mpd = {
    enable = true;
    # user = "noor";
    musicDirectory = /home/noor/Soulseek/Music;
    startWhenNeeded = true;
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };
}
