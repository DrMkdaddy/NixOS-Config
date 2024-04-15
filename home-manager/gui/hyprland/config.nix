{
  wayland.windowManager.hyprland.extraConfig = ''
      exec-once = wl-clipboard-history -t
      exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
      exec-once = swww init
      exec-once = dunst
      exec-once = waybar

      monitor= DP-3,preferred,1920x0,1
      workspace= DP-3,1

      monitor= HDMI-A-1,preferred,0x180,1
      workspace= HDMI-A-1,2
      input {
        kb_layout = us
        follow_mouse = 1
        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }
      general {
        gaps_in=5
        gaps_out=5
        border_size=0
        no_border_on_floating = true
        layout = dwindle
      }
      misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        mouse_move_enables_dpms = true
        enable_swallow = true
        swallow_regex = ^(kitty)$
        swallow_regex = ^(zellij)$
      }

      decoration {
        rounding = 8
        active_opacity = 1.0
        inactive_opacity = 1.0

        blur {
          enabled = true
          passes = 3
          size = 3
        }

        # Shadow
        drop_shadow = true
        shadow_ignore_window = true
        shadow_offset = 2 2
        shadow_range = 4
        shadow_render_power = 2
        col.shadow = 0x66000000

        blurls = gtk-layer-shell
        blurls = waybar
        blurls = lockscreen
      }

      animations {
        enabled = true
         bezier = overshot, 0.05, 0.9, 0.1, 1.05
         bezier = smoothOut, 0.36, 0, 0.66, -0.56
         bezier = smoothIn, 0.25, 1, 0.5, 1

        animation = windows, 1, 5, overshot, slide
        animation = windowsOut, 1, 4, smoothOut, slide
        animation = windowsMove, 1, 4, default
        animation = border, 1, 10, default
        animation = fade, 1, 10, smoothIn
        animation = fadeDim, 1, 10, smoothIn
        animation = workspaces, 1, 6, default
      }

      dwindle {
        no_gaps_when_only = false
        preserve_split = true
      }
      windowrule = float, file_progress
      windowrule = float, confirm
      windowrule = float, dialog
      windowrule = float, download
      windowrule = float, notification
      windowrule = float, error
      windowrule = float, splash
      windowrule = float, confirmreset
      windowrule = float, title:Open File
      windowrule = float, title:branchdialog
      windowrule = float, Rofi
      windowrule = float,viewnior
      windowrule = float,feh
      windowrule = float, pavucontrol-qt
      windowrule = float, pavucontrol
      windowrule = float, file-roller
      windowrule = fullscreen, wlogout
      windowrule = float, title:wlogout
      windowrule = fullscreen, title:wlogout
      windowrule = idleinhibit focus, mpv
      windowrule = idleinhibit fullscreen, firefox
      windowrule = float, title:^(Media viewer)$
      windowrule = float, title:^(Volume Control)$
      windowrule = float, title:^(Picture-in-Picture)$
      windowrule = size 800 600, title:^(Volume Control)$
      windowrule = move 75 44%, title:^(Volume Control)$
      windowrule = float, dragon-drop
      windowrule = pin, dragon-drop
      layerrule = ignorezero, waybar


      exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

     bind = SUPER, M, exec, /usr/bin/env  kitty
     bind = ,XF86MonBrightnessDown, exec, brightnessctl s 5%-
     bind = ,XF86MonBrightnessUp, exec, brightnessctl s 5%+
     bind = SUPER, I, exec, hyprpicker -f hex -a

     binde=, XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise
     binde=, XF86AudioLowerVolume, exec, swayosd-client --output-volume lower
     binde=, XF86AudioMute, exec, swayosd-client --output-volume mute-toggle
     bind=, XF86AudioPlay, exec, playerctl play-pause
     bind=, XF86AudioPause, exec, playerctl play-pause
     bind=, XF86AudioNext, exec, playerctl next
     bind=, XF86AudioPrev, exec, playerctl previous


    bind = SUPER SHIFT, X, exec, hyprpicker -a -n

    bind = SUPER, Q, killactive,
    bind = SUPER SHIFT, Q, exit,
    bind = SUPER, F, fullscreen,
    bind = SUPER, Space, togglefloating,
    bind = SUPER, P, pseudo, # dwindle
    bind = SUPER, S, togglesplit, # dwindle
    bind = SUPER, R, exec, anyrun
    bind = SUPER, E, exec, emoji

    bind = ,Print,exec,grimblast copysave screen && notify-send "Screenshot Saved"
    bind = SUPER + SHIFT, Print, exec, grimblast copysave active && notify-send "Screenshot Saved"
    bind = SUPER, Print ,exec, grimblast copysave area && notify-send 'Screenshot Saved'

    bind = SUPER, left, movefocus, l
    bind = SUPER, right, movefocus, r
    bind = SUPER, up, movefocus, u
    bind = SUPER, down, movefocus, d

    bind = SUPER SHIFT, left, movewindow, l
    bind = SUPER SHIFT, right, movewindow, r
    bind = SUPER SHIFT, up, movewindow, u
    bind = SUPER SHIFT, down, movewindow, d

    bind = SUPER CTRL, left, resizeactive, -20 0
    bind = SUPER CTRL, right, resizeactive, 20 0
    bind = SUPER CTRL, up, resizeactive, 0 -20
    bind = SUPER CTRL, down, resizeactive, 0 20

    bind= SUPER, g, togglegroup
    bind= SUPER, tab, changegroupactive

    bind = SUPER, grave, togglespecialworkspace
    bind = SUPERSHIFT, grave, movetoworkspace, special

    ${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          bind = SUPER, ${ws}, workspace, ${toString (x + 1)}
          bind = SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        ''
      )
      10)}

    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow
    bind = SUPER, mouse_down, workspace, e+1
    bind = SUPER, mouse_up, workspace, e-1
  '';
}
