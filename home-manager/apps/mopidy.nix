{pkgs, ...}: {
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [mopidy-spotify mopidy-mpd mopidy-mpris];
    settings = {
      file = {
        media_dirs = [
          "$XDG_MUSIC_DIR|Music"
          "~/library|Library"
          "~/Soulseek"
        ];
        follow_symlinks = true;
        excluded_file_extensions = [
          ".html"
          ".zip"
          ".jpg"
          ".jpeg"
          ".png"
          ".pdf"
          ".zip"
        ];
      };
    };
  };
}
