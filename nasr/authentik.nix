{
  pkgs,
  config,
  inputs,
  ...
}: {
  age.secrets.authentikenv.file = ../secrets/authentikenv.age;

  services.authentik = {
    enable = true;
    environmentFile = config.age.secrets.authentikenv.path;
    disable_startup_analytics = true;
    avatars = "initials";
  };
}
