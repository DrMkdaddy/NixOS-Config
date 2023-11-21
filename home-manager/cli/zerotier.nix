{pkgs, ...}: {
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "885033839021ec8e"
      "8850338390c5a203"
    ];
  };
}
