{
  pkgs,
  config,
  ...
}: {
  imports = [
  ];
  home.file.".wallpapers".source = ./img;
  # Shamelessly plagrized from https://github.com/sayanta01/dotfiles/blob/main/.local/bin/wallch
  home.packages = with pkgs; let
    swwwitch2 = pkgs.writeShellScriptBin "swwwitch2" ''
      #!/bin/sh
      dir="${config.home.homeDirectory}/.wallpapers/"
      BG="$(find "$dir" -name '*.jpg' -o -name '*.png' -o -name '*.gif' | shuf -n1)"
      PROGRAM="swww-daemon"
      trans_type="outer"

      # Check if the program is running
      if pgrep "$PROGRAM" >/dev/null; then
      	swww img "$BG" --transition-fps 244 --transition-type $trans_type --transition-pos 0.854,0.977 --transition-duration 1
      else
      	swww init && swww img "$BG" --transition-fps 244 --transition-type $trans_type --transition-duration 1
      fi
      echo "Switched Wallpapers?"
    '';
  in [
    swwwitch2
  ];
}
