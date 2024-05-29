{
  pkgs,
  config,
  ...
}: {
  age.secrets.nextcloud.file = ../secrets/nextcloud.age;
  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"];
    externalInterface = "ens3";
    # Lazy IPv6 connectivity for the container
    enableIPv6 = true;
  };

  containers.nextcloud = {
    bindMounts = {
      "/etc/secret/" = {
        hostPath = "${config.age.secrets.nextcloud.path}";
        isReadOnly = true;
      };
      "/var/lib/nextcloud" = {hostPath = "/home/noor/nextcloud";};
    };
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";
    config = {
      config,
      pkgs,
      lib,
      ...
    }: {
      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud29;
        hostName = "nextcloud.godilove.rocks";
        # Use HTTPS for links
        https = true;

        # Auto-update Nextcloud Apps
        autoUpdateApps.enable = true;
        # Set what time makes sense for you
        autoUpdateApps.startAt = "05:00:00";

        config = {
          # Further forces Nextcloud to use HTTPS
          overwriteProtocol = "https";

          # Nextcloud PostegreSQL database configuration, recommended over using SQLite
          dbtype = "pgsql";
          dbuser = "nextcloud";
          dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
          dbname = "nextcloud";
          dbpassFile = "/var/nextcloud-db-pass";
          adminpassFile = "/etc/secret/nextcloud.age";

          adminuser = "drmkdaddy";
        };
      };

      services.postgresql = {
        enable = true;

        # Ensure the database, user, and permissions always exist
        ensureDatabases = ["nextcloud"];
        ensureUsers = [
          {
            name = "nextcloud";
            ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
          }
        ];
      };

      system.stateVersion = "24.05";

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [80];
        };
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;
    };
  };
}
