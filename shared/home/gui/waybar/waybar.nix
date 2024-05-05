{
  pkgs,
  lib,
  ...
}: let
  dir = ./.;
in {
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "bottom";
        height = 13;
        width = 1920;
        margin = "2, 0, 1, 0";

        # Modules
        modules-left = [
          "cpu"
          "memory"
          "temperature"
          "network"
          "custom/recorder"
          "custom/audiorec"
        ];
        modules-center = [
          "custom/archlogo"
          "hyprland/workspaces"
        ];
        modules-right = [
          "backlight"
          "battery"
          "pulseaudio"
          "clock"
        ];

        # Left Side Modules
        "custom/archlogo" = {
          tooltip = false;
          format = "  ";
          on-click = "swwwitch";
        };
        "custom/wmname" = {
          tooltip = false;
          format = "󰍹 ";
        };
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
          };
        };
        cpu = {
          tooltip = false;
          format = "  {usage}%";
          on-click = "${pkgs.kitty}/bin/kitty -e btop";
        };
        memory = {
          tooltip = false;
          format = " {used:0.2f}GB";
          max-length = 10;
          warning = 70;
          critical = 90;
        };
        network = {
          tooltip = true;
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰤨 {ifname} {ipaddr}/{cidr}";
          format-linked = "󱚵 (NO IP)";
          format-disconnected = "󰀝 Disconnected :(";
          tooltip-format = "{essid} - {ipaddr}";
        };
        "custom/recorder" = {
          format = "󰄄 Rec";
          format-disable = "󰄄 Off-air";
          return-type = "json";
          interval = 20;
          exec = "echo '{\"class\": \"recording\"}'";
          exec-if = "pgrep wf-recorder";
        };
        "custom/audiorec" = {
          format = " Rec";
          format-disable = " Off-air";
          return-type = "json";
          interval = 20;
          exec = "echo '{\"class\": \"audio recording\"}'";
          exec-if = "pgrep ffmpeg";
        };

        # Center Modules

        # Right Modules
        tray = {
          icon-size = 20;
          spacing = 10;
        };
        backlight = {
          tooltip = false;
          format = "{icon} {percent}%";
          format-icons = ["󰌶" "󰌵"];
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl s 1%-";
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl s +1%";
        };
        battery = {
          tooltip = false;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "󱐋 {capacity}%";
          format-plugged = "󱐋 {capacity}%";
          format-icons = ["" "" "" "" ""];
        };
        temperature = {
          hwmon-path = "/sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input";
          critical_threshold = 80;
          format-critical = "󰸁 {temperatureC}󰔄";
          format = "{icon} {temperatureC}󰔄";
          format-icons = ["" "" ""];
        };
        pulseaudio = {
          format = "{icon} {volume}% {format_source}";
          format-muted = "󰝟 {format_source}";
          format-source = " {volume}%";
          format-source-muted = " ";
          format-bluetooth = "{icon} 󰂰 {volume}% {format_source}";
          format-bluetooth-muted = "󰂲 {format_source}";
          format-icons = {
            headphone = "󰋋";
            hands-free = "";
            headset = "󰋎";
            phone = "";
            portable = "󰦢";
            car = "";
            default = ["" "󰕾" ""];
          };
          on-click = "kill $(pgrep pavucontrol) || ${pkgs.pavucontrol}/bin/pavucontrol";
        };
        clock = {
          tooltip = true;
          interval = 20;
          local = "C";
          timezone = "America/Los_Angeles";
          format = "󱑆 {:%I:%M %p}";
          tooltip-format = "{:%a, %b %d}";
        };
      }
    ];
    style = ''
      ${builtins.readFile "${dir}/style.css"}
    '';
  };
}
