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
            terminal: Some("kitty"),
            max_entries: 30,
        )
      '';
    };
    extraCss=''
        * {
          transition: 200ms ease;
        }

        #window,
        #match,
        #entry,
        #plugin,
        #main {
          background: transparent;
        }

        #match:selected {
          background: rgba(203, 166, 247, 0.7);
        }

        #match {
          padding: 3px;
          border-radius: 5px;
        }

        #entry, #plugin:hover {
          border-radius: 8px;
        }

        box#main {
          background: rgba(30, 30, 46, 1);
          border: 1px solid #28283d;
          border-radius: 16px;
          padding: 5px;
        }
    '';
  };
}
