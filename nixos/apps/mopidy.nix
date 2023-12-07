{pkgs, ...}: {
  services.mopidy = {
    enable = true;
    extensionPackages = [];
    configuration = ''
      [local]
        enabled = true
        library = json
        media_dir = /home/noor/Soulseek/Music
        data_dir = $XDG_DATA_DIR/mopidy/local
        playlists_dir = $XDG_DATA_DIR/mopidy/local/playlists
        scan_timeout = 1000
        scan_flush_threshold = 1000
        excluded_file_extensions =
          .directory
          .html
          .jpeg
          .jpg
          .log
          .nfo
          .png
          .txt
    '';
  };
}
