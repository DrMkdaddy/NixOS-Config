{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Noor Mkdad";
    userEmail = "alph4nir@riseup.net";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
      p = "push";
      ca = "commit -a";
    };
    extraConfig = {
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };
}
