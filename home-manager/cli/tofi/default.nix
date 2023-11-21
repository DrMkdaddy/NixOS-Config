{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; let
    # TODO: ADD SCRIPTS TO HANDLE VIDEO IN DIRECTORIES WITH MPV
    # TODO: MAKE THAT BOOKMARK HANDLER
    # TODO: RIP MORE STUFF OFF (WHY WRITE IT YOURSELF!!!!!!)
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
    zipmenu = pkgs.writeShellScriptBin "zipmenu" ''
      #!/bin/sh
      unzip $(eza -1 *.zip | tofi)
    '';
    rgmenu = pkgs.writeShellScriptBin "rgmenu" ''
      #!/bin/sh
      nvim $(rg ''$1 | cut -f1 -d ":" | tofi)
    '';
  in [
    # for compatibility sake
    (writeScriptBin "dmenu" ''exec ${lib.getExe tofi}'')
    tofi
    emoji
    wtype
    zipmenu
    rgmenu
  ];
  xdg.configFile."tofi/config".text = ''
    font = FiraCode Nerd Font
    font-size = 11
    horizontal = true
    anchor = top
    width = 100%
    height = 40
    outline-width = 0
    border-width = 0
    min-input-width = 120
    result-spacing = 30
    padding-top = 10
    padding-bottom = 10
    padding-left = 20
    padding-right = 0
    margin-top = 0
    margin-bottom = 0
    margin-left = 15
    margin-right = 0
    prompt-text = "-> "
    prompt-padding = 301
    background-color = #1a1b26
    text-color = #cfc9c2
    prompt-color = #bb9af7
    prompt-background = #1a1b26
    prompt-background-padding = 4, 10
    prompt-background-corner-radius = 12
    input-background = #1a1b26
    input-background-padding = 4, 10
    input-background-corner-radius = 12
    selection-color = #7aa2f7
    selection-background = #1a1b26
    selection-background-padding = 4, 10
    selection-background-corner-radius = 12
    selection-match-color = #73daca
    clip-to-padding = false
  '';
}
