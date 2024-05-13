{pkgs, ...}: {
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "8850338390c5a203"
      "885033839021ec8e"
    ];
  };
}
