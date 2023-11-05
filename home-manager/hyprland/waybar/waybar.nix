{pkgs, lib, ...}:

{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position  = "top";
      margin = "3, 0, 2, 0";

      # Modules
      modules-left = [
	"custom/archlogo"
	"custom/wmname"
	"hyprland/workspaces"
	"cpu"
	"memory"
	"network"
	"custom/recorder"
	"custom/audiorec"
      ];
      modules-center = [
#	"custom/spotify" # TODO CHANGE TO NOT FUCKING SUCK. USE MPD OR SOMETHING NORMAL NOT A BUMFUCK RANDOM PYTHON SCRIPT
      ];
      modules-right = [
	"tray"
	"backlight"
	"battery"
	"temprature"
	"pulseaudio"
	"clock"
      ];
      
      # Left Side Modules
      "custom/archlogo" = {
	tooltip = false;
	format = "    ";
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
	format = "  : {usage}%";
	on-click = "kitty -e btop";
      };
      memory = {
	tooltip = false;
	format = "  : {used:0.2f}GB";
	max-length = 10;
	warning = 70;
	critical = 90;
      };
      network = {
	tooltip = false;
	format-wifi = "{essid} 󰤨 : {signalStrength}%     ";
	format-ethernet = "󰤨 {ifname}: {ipaddr}/{cidr}";
	format-linked = "󱚵 (NO IP)";
	format-disconnected = "󰀝 Disconnected :(";
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
	format = "{icon}: {percent}%";
	format-icons = ["󰌶 " "󰌵 "];
	on-scroll-down = "brightnessctl s -1%";
	on-scroll-up = "brightnessctl s +1%";
      };
      battery = {
	tooltip = false; 
	states = {
	  warning = 30;
	  critical = 15;
	};
	format = "{icon} : {capacity}%";
	format-charging = "󱐋 : {capacity}%";
	format-plugged = "󱐋 : {capacity}%";
	format-alt = "{icon} : {time}";
	format-icons = ["  " "  " "  " "  " "  :D"];
      };
      temprature = {
	thermal-zone = 2;
	hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
	critical_threshold = 80;
	format-critical = "{tempratureC}󰔄 {icon} ";
	format = "{icon} {tempratureC}󰔄 ";
	format-icons = [" " " " " "];
      };
      pulseaudio = {
	format = "{icon} : {volume}% {format_source}";
	format-muted = "󰝟 {format_source}";
	format-source = " : {volume}%";
	format-source-muted = " ";
	format-bluetooth = "{icon} 󰂰 : {volume}% {format_source}";
	format-bluetooth-muted = "󰂲 {format_source}";
	format-icons = {
	  headphone = "󰋋 ";
	  hands-free = " ";
	  headset = "󰋎 ";
	  phone = " ";
	  portable = "󰦢 ";
	  car = " ";
	  default = [" " "󰕾 " " "];
	};
	on-click = "pavucontrol";
      };
      clock = {
	interval = 20;
	local = "C";
	timezone = "America/Los_Angeles";
	format = "  : {:%I:%M %p}";
	format-alt = "  : {:%a, %b %d}";
      };
    }];
    style = ''
      ${builtins.readFile."./monokai/style.css"}
    '';
  };
}
