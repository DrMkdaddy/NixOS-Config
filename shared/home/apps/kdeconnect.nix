{pkgs, inputs, ...}: 
{
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
