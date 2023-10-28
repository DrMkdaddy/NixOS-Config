{pkgs, ...}: {
  programs.gtk = {
    enable = true;
    iconTheme = {
      name = "fluent-icon-theme";
      package = pkgs.fluent-icon-theme;
    };
    theme = {
      name = "yaru-dark";
      package = pkgs.yaru-theme;
    };
    cursorTheme = {
      name = "yaru-dark-cursor-thene";
      package = pkgs.yaru-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  home.sessionVariables.GTK_THEME = "yaru-dark";
}
