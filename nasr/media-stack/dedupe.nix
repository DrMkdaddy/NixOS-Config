{
  lib,
  pkgs,
  ...
}: let
  dedupe = ''
    ${lib.getExe pkgs.jdupes} -rLX onlyext:mp4,mkv,avi "/mnt/nuclearmissilesilo/jellyfish/" "/mnt/nuclearmissilesilo/jellyfish/media"
  '';
in {
  systemd = {
    timers."dedupe" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "dedupe.service";
      };
    };
    services."dedupe" = {
      script = dedupe;
      serviceConfig = {
        Type = "oneshot";
        User = "root";
        Group = "root";
      };
    };
  };
}
