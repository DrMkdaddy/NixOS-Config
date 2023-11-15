{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; let
    emoji = pkgs.writeShellScriptBin "emoji" ''
      #!/bin/sh
      chosen=$(cut -d ';' -f1 ${./emoji} | tofi | sed "s/ .*//")
      [ -z "$chosen" ] && exit
      if [ -n "$1" ]; then
      	wtype "$chosen"
      else
      	printf "$chosen" | wl-copy
      	notify-send "'$chosen' copied to clipboard." &
      fi
    '';
  in [
    # for compatibility sake
    (writeScriptBin "dmenu" ''exec ${lib.getExe tofi}'')
    tofi
    emoji
    wtype
  ];
  xdg.configFile."tofi/config".text = {
  };
}
