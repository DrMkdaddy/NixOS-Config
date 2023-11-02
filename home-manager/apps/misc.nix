{pkgs, ...}: {
  home.packages = with pkgs; [
    armcord
    bottles
    obsidian
    (discord.override {
  # remove any overrides that you don't want
  withOpenASAR = true;
  withVencord = true;
})
  ];
}
