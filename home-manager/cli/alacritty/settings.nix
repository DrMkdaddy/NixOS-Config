{
  programs.alacritty.settings = {
    # TODO: GET THIS WORKING
    env = {
      "TERM" = "xterm-256color";
    };

    window = {
      padding.x = 10;
      padding.y = 10;
      decorations = "Full";
      opacity = 0.90;
    };

    font = {
      size = 11.0;
      normal = {
        family = "FiraCode Nerd Font";
        style = "Regular";
      };
      bold = {
        family = "FiraCode Nerd Font";
        style = "Bold";
      };
      italic = {
        family = "FiraCode Nerd Font";
        style = "Italic";
      };
      user_thin_strokes = false;
    };

    cursor.style = "Beam";

    shell = {
      program = "fish";
    };
  };
}
