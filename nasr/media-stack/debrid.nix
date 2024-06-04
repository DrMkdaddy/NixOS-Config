{pkgs, ...}: {
  virtualisation.oci-containers.containers.realdebridmanager = {
    autoStart = true;
    image = "docker.io/hyperbunny77/realdebridmanager:2022.06.27";
    ports = "5000:5000";
    volumes = [
      "/mnt/nuclearmissilesilo/jellyfish/media:/watch"
      "config_debrid:/config"
    ];
  };
}
