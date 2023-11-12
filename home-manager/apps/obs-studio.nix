{pkgs, ...}:
{
  programs.obs-studio = {
    enable = true; 
    plugins = with pkgs.obs-studio-plugins; [
      obs-gstreamer
      obs-pipewire-audio-capture
      obs-vkcapture
      obs-studio-plugins.wlrobs
    ];
  };
}
