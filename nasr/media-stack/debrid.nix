_: {
  virtualisation.oci-containers.containers."real-debrid2" = {
    autoStart = true;
    image = "docker.io/rogerfar/rdtclient:latest";
    ports = ["6500:6500"];
    volumes = [
      "/mnt/nuclearmissilesilo/jellyfish/debrid:/data/downloads"
      "/home/noor/debrid:/data/db"
      "/debrid1/:/debrid-mount"
    ];
  };
}
