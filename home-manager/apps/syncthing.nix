{
  services = {
    syncthing = {
      enable = true;
      user = "noor";
      dataDir = "/home/noor/Documents";
      configDir = "/home/noor/Documents/.config/syncthing";
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      overrideFolders = true; # overrides any folders added or deleted through the WebUI
      devices = {
        "Berzerkergor" = {id = "EI673CB-3BO62J7-25E4P5O-DPKMMGD-A6GGNN4-TXRARFF-RZ4LRLA-T7X3UAK";};
      };
      folders = {
        "Documents" = {
          # Name of folder in Syncthing, also the folder ID
          path = "/home/myusername/Documents"; # Which folder to add to Syncthing
          devices = ["device1" "device2"]; # Which devices to share the folder with
        };
      };
    };
  };
}
