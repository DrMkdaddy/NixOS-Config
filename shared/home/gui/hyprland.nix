{
  pkgs,
  inputs,
  ...
}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    ${pkgs.dunst}/bin/dunst &
    ${pkgs.wl-clipboard}/bin/wl-clipboard-history -t &
    ${pkgs.swayosd}/bin/swayosd-server &
    systemctl --user import-eviroment WAYLAND_DISPLAY &
  '';
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.variables = ["--all"];
    settings = {
      "$mod" = "SUPER";
      exec-once = ''${startupScript}/bin/start'';
      bind =
        [
          "$mod, M, exec, ${pkgs.kitty}/bin/kitty"
          ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
          ",XF86MonBrightnessUp, exec, brightnessctl s 5%+"
          "$mod, I, exec, hyprpicker -f hex -a"
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPause, exec, playerctl play-pause"
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"
          "$mod SHIFT, X, exec, hyprpicker -a -n"
          "$mod, Q, killactive,"
          "$mod SHIFT, Q, exit,"
          "$mod, F, fullscreen,"
          "$mod, Space, togglefloating,"
          "$mod, P, pseudo, # dwindle"
          "$mod, S, togglesplit, # dwindle"
          "$mod, R, exec, anyrun"
          "$mod, E, exec, emoji"
          ",Print,exec,grimblast copysave screen && notify-send 'Screenshot Saved'"
          "$mod + SHIFT, Print, exec, grimblast copysave active && notify-send 'Screenshot Saved'"
          "$mod, Print ,exec, grimblast copysave area && notify-send 'Screenshot Saved'"
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"
          "$mod CTRL, left, resizeactive, -20 0"
          "$mod CTRL, right, resizeactive, 20 0"
          "$mod CTRL, up, resizeactive, 0 -20"
          "$mod CTRL, down, resizeactive, 0 20"
          "$mod, g, togglegroup"
          "$mod, tab, changegroupactive"
          "$mod, grave, togglespecialworkspace"
          "$modSHIFT, grave, movetoworkspace, special"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
      binde = [
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      monitor = [
        "DP-3,preferred,1920x0,1"
        "HDMI-A-1,preferred,0x180,1"
      ];
      workspace = "DP-3,1";
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
      };
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 0;
        no_border_on_floating = true;
        layout = "dwindle";
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = ["^(kitty)$" "^(zellij)$"];
      };
      decoration = {
        rounding = 8;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = true;
          passes = 3;
          size = 3;
        };
        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_offset = "2 2";
        shadow_range = 4;
        shadow_render_power = 2;
        "col.shadow" = "0x66000000";
        blurls = [
          "gtk-layer-shell"
          "waybar"
          "lockscreen"
        ];
      };
      animations = {
        enabled = true;
        bezier = [
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
        ];
        animation = [
          "windows, 1, 5, overshot, slide"
          "windowsOut, 1, 4, smoothOut, slide"
          "windowsMove, 1, 4, default"
          "border, 1, 10, default"
          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        no_gaps_when_only = false;
        preserve_split = true;
      };
      windowrule = [
        "float, file_progress"
        "float, confirm"
        "float, dialog"
        "float, download"
        "float, notification"
        "float, error"
        "float, splash"
        "float, confirmreset"
        "float, title:Open File"
        "float, title:branchdialog"
        "float, Rofi"
        "float,viewnior"
        "float,feh"
        "float, pavucontrol-qt"
        "float, pavucontrol"
        "float, file-roller"
        "fullscreen, wlogout"
        "float, title:wlogout"
        "fullscreen, title:wlogout"
        "idleinhibit focus, mpv"
        "idleinhibit fullscreen, firefox"
        "float, title:^(Media viewer)$"
        "float, title:^(Volume Control)$"
        "float, title:^(Picture-in-Picture)$"
        "size 800 600, title:^(Volume Control)$"
        "move 75 44%, title:^(Volume Control)$"
        "float, dragon-drop"
        "pin, dragon-drop"
      ];
      layerrule = ["ignorezero, waybar"];
    };
  };
}
