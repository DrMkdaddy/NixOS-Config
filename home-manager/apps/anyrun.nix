{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.anyrun.homeManagerModules.default];
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with inputs.anyrun.packages."x86_64-linux";
        [
          applications
          rink
          translate
          randr
          shell
          symbols
          translate
        ]
        ++ [inputs.anyrun-nixos-options.packages."x86_64-linux".default];
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
      "dictionary.ron".text = ''
        Config(
            prefix: ":d",
        )
      '';
      "symbols.ron".text = ''
        Config(
            prefix: ":s",
        )
      '';
      "translate.ron".text = ''
        Config(
            prefix: ":",
            language_delimiter: ">",
        )
      '';
    };
  };
}
