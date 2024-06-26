{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    grimblast
    python3
    wl-clipboard
    nodePackages_latest.vim-language-server
    python311Packages.python-lsp-server
    brightnessctl
    gh
    nil
    zoxide
    alejandra
    powertop
    lf
    eza
    libnotify
    xdragon
    tmatrix
    psmisc
    swayosd
    ripgrep
    repgrep
    lm_sensors
    distrobox
    xdg-utils
    gcc
    nodejs
    tree-sitter
    jq
    unzip
    bat
    fd
    fastfetch
    inotify-tools
    nix-your-shell
  ];
}
