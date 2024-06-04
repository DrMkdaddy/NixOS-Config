{config, ...}: {
  # docker run -d \
  # --name aria2-pro \
  # --restart unless-stopped \
  # --log-opt max-size=1m \
  # -e PUID=$UID \
  # -e PGID=$GID \
  # -e UMASK_SET=022 \
  # -e RPC_SECRET=<TOKEN> \
  # -e RPC_PORT=6800 \
  # -p 6800:6800 \
  # -e LISTEN_PORT=6888 \
  # -p 6888:6888 \
  # -p 6888:6888/udp \
  # -v $PWD/aria2-config:/config \
  # -v $PWD/aria2-downloads:/downloads \
  # p3terx/aria2-pro
  age.secrets.aria2-token.file = ../../secrets/aria2c-token.age;
  virtualisation.oci-containers.containers = {
    realdebridmanager = {
      autoStart = true;
      image = "docker.io/hyperbunny77/realdebridmanager:2022.06.27";
      ports = ["5000:5000"];
      volumes = [
        "/mnt/nuclearmissilesilo/jellyfish/debrid:/watch"
        "config_debrid:/config"
      ];
      environment = {rdmport = "5000";};
    };
    aria2-pro = {
      autoStart = true;
      image = "p3terx/aria2-pro";
      volumes = ["config_aria2:/config" "/mnt/nuclearmissilesilo/jellyfish/debrid:/downloads"];
      environment = {
        RPC_SECRET = "$(cat ${config.age.secrets.aria2-token.path})";
        RPC_PORT = "6800";
        LISTEN_PORT = "6888";
      };
      ports = ["6800:6800" "6888:6888/udp"];
    };
  };

  networking.firewall.allowedTCPPorts = [5000];
}
