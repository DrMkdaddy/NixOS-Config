{pkgs, ...}: {
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "8850338390c5a203"
    ];
  };
}
