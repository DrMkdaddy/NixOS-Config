let
  nasr = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA9WI9j2tKL+o2MvKLMnmNxA4D8gblg+iCmUInEX6hHk nasr_identity";
  hosts = [nasr];
in {
  "nextcloud.age".publicKeys = [nasr];
  "postgres_nextcloud.age".publicKeys = [nasr];
}
