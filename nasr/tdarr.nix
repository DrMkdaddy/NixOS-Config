_: {
  virtualisation.oci-containers.containers.tdarr = {
    autoStart = true;
    image = "ghcr.io/haveagitgat/tdarr";
    volumes = [
      "/home/noor/docker/tdarr/server:/app/server"
      "/home/noor/docker/tdarr/configs:/app/configs"
      "/home/noor/docker/tdarr/logs:/app/logs"
      "/mnt/nuclearmissilesilo/jellyfish/media:/media"
      "/mnt/nuclearmissilesilo/transcode_cache:/temp"
    ];
    environment = {
      serverIP = "0.0.0.0";
      serverPort = "8266";
      webUIPort = "8265";
      internalNode = "true";
      inContainer = "true";
      ffmpegVersion = "6";
      nodeName = "InternalNode";
      TZ = "America/Los_Angeles";
      NVIDIA_DRIVER_CAPABILITIES = "all";
      NVIDIA_VISIBLE_DEVICES = "all";
    };
    ports = ["8265:8265" "8266:8266"];
    extraOptions = [
      "-ti"
      "-gpus=all"
      "--device=/dev/dri:/dev/dri"
      "--log-opt max-size=10m"
      "--log-opt max-file=5"
    ];
  };
}
