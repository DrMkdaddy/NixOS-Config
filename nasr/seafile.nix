{
  config,
  pkgs,
  ...
}: {
  networking.firewall.allowedTCPPorts = [80 443];
  environment.systemPackages = [pkgs.nssTools];
  imports = [
    ./nextcloud-extras.nix
  ];

  age.secrets.nextcloud = rec {
    file = ../secrets/nextcloud.age;
    owner = "nextcloud";
    group = owner;
    mode = "400";
  };

  services.nextcloud = {
    enable = true;
    https = true;
    hostName = "nasr.spotted-powan.ts.net";
    webserver = "caddy";

    # Need to manually increment with every major upgrade.
    package = pkgs.nextcloud29;

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
