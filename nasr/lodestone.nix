_: {
  virtualisation.oci-containers.containers = {
    image = "ghcr.io/lodestone-team/lodestone_core";
    autoStart = true;
    ports = [
      "16662:16662"
      "25565:25565"
    ];
    volumes = ["lodestone:/home/user/.lodestone"];
  };
  networking.firewall = {
    allowedTCPPorts = [16662 25565];
    allowedUDPPorts = [25565];
  };
}
