{
  env = {
    "TERM" = "xterm-256color";
  };

  background_opacity = 0.95;

  window = {
    padding.x = 10;
    padding.y = 10;
    decorations = "buttonless";
  };

  font = {
    size = 12.0;
    use_thin_strokes = true;

    normal.family = "FiraCode Nerd Font";
    bold.family = "FiraCode Nerd Font";
    italic.family = "FiraCode Nerd Font";
  };

  cursor.style = "Beam";

  shell = {
    program = "fish";
  };

  colors = lib.attrsets.recursiveUpdate (import ./colors.nix);
}
