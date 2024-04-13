{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    fishIntegration = true;
  };
}
