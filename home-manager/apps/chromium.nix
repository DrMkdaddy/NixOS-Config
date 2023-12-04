{
  pkgs,
  nixpkgs,
  ...
}: {
  programs.chromium = {
    enable = true;
  };
}
