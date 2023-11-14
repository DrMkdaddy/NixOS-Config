{
  builtins,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = builtins.readFile ./settings.yml ++ builtins.readFile ./theme.yml
  };
}
