{
  pkgs,
  inputs, 
  ...
}: {
  imports = [inputs.anyrun.homeManagerModules.default];
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system};
        [
          applications
        ];
        # ++ [inputs.anyrun-nixos-options.packages.${pkgs.system}.default];
      width = {fraction = 0.3;};
      y.fraction = 0.02;
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = 10;
    };
    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
            desktop_actions: true,
            terminal: Some("foot"),
            max_entries: 30,
        )
      '';
    };
    extraCss=''
      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }
    '';
  };
}
