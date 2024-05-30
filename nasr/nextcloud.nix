{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.nssTools];
  imports = [
    "${fetchTarball {
      url = "https://github.com/onny/nixos-nextcloud-testumgebung/archive/fa6f062830b4bc3cedb9694c1dbf01d5fdf775ac.tar.gz";
      sha256 = "0gzd0276b8da3ykapgqks2zhsqdv4jjvbv97dsxg0hgrhb74z0fs";
    }}/nextcloud-extras.nix"
  ];

  age.secrets.nextcloud = rec {
    file = ../secrets/nextcloud.age;
    owner = "nextcloud";
    group = owner;
    mode = "400";
  };

  services.nextcloud = {
    enable = true;
    hostName = "nasr.spotted-powan.ts.net";
    webserver = "caddy";

    # Need to manually increment with every major upgrade.
    package = pkgs.nextcloud28;

    # Let NixOS install and configure the database automatically.
    database.createLocally = true;

    # Let NixOS install and configure Redis caching automatically.
    configureRedis = true;

    # Increase the maximum file upload size to avoid problems uploading videos.
    maxUploadSize = "16G";

    autoUpdateApps.enable = true;
    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      # List of apps we want to install and are already packaged in
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
      inherit calendar contacts mail notes onlyoffice tasks;
    };

    config = {
      overwriteProtocol = "https";
      defaultPhoneRegion = "PT";
      dbtype = "pgsql";
      adminuser = "admin";
      adminpassFile = config.age.secrets.nextcloud.path;
    };
  };
}
