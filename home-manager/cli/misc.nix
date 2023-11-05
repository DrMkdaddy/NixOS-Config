{pkgs, ...}: {
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
    freshfetch
    tmatrix
    psmisc
    swayosd
    ripgrep
    repgrep
  ];
}
