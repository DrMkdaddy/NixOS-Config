{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  age.secrets.authentik.file = ../secrets/authentikenv.age;
  services.authentik = {
    enable = true;
    environmentFile = config.age.secrets.authentik.path;
    settings = {
      disable_startup_analytics = true;
      avatars = "initials";
    };
  };
}
