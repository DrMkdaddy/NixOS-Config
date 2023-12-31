{pkgs, ...}: {
  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = /home/noor/Soulseek/Music;
    settings = {
      mpd_music_dir = "/home/noor/Soulseek/Music/";
      mpd_connection_timeout = "5";
      mpd_crossfade_time = "5";
      playlist_disable_highlight_delay = "0";
      # song_list_format = "{$3[%l]$9} {$5%a$9} {$6%t$9} %y  %n {$5%b$9}";
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      incremental_seeking = "yes";
      autocenter_mode = "yes";
      header_visibility = "yes";
      statusbar_visibility = "yes";
      # fancy_scrolling = "yes";
      follow_now_playing_lyrics = "yes";
      # display_screens_numbers_on_start = "yes";
      ignore_leading_the = "yes";
      # lyrics_database = "1";
      colors_enabled = "yes";
    };
  };
}
