# For Linux and without a web server or reverse proxy (like Apache, Nginx, Cloudflare Tunnel and else) already in place:
# sudo docker run \
# --init \
# --sig-proxy=false \
# --name nextcloud-aio-mastercontainer \
# --restart always \
# --publish 80:80 \
# --publish 8080:8080 \
# --publish 8443:8443 \
# --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
# --volume /var/run/docker.sock:/var/run/docker.sock:ro \
# nextcloud/all-in-one:latest
_: {
  virtualisation.oci-containers.containers.nextcloud-aio-mastercontainer = {
    autoStart = true;
    image = "docker.io/nextcloud/all-in-one:latest";
    ports = ["80:80" "8080:8080" "8443:8443"];
    volumes = [
      "nextcloud_aio_mastercontainer:/mnt/docker-aio-config"
      "/var/run/docker.sock:/var/run/docker.sock:ro"
    ];
    environment = {
      # SKIP_DOMAIN_VALIDATION = "true";
      APACHE_PORT = "11000";
      APACHE_IP_BINDING = "0.0.0.0";
    };
    extraOptions = ["--sig-proxy=false" "--init"];
  };
}
