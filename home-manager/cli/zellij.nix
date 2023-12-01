{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    settings = {
      scrollback_editor = "${pkgs.neovim}/bin/nvim";
      copy_command = "wl-copy";
      pane_frames = false;
      default_layout = "compact";
      theme = "tokyo-night-dark";
      themes.tokyo-night-dark = {
        fg = "#A9B1D6";
        bg = "#1A1B26";
        black = "#383E5A";
        red = "#F93357";
        green = "#9ECE6A";
        yellow = "#E0AF68";
        blue = "#7AA2F7";
        magenta = "#BB9AF7";
        cyan = "#2AC3DE";
        white = "#C0CAF5";
        orange = "#FF9E64";
      };
    };
  };
}
