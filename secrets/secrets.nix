let
  noor = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGseecepDJw0Q3ZdwF3vT+5tItl3wSMlaw1qQsl/+St7 noor@idris";
  nasr = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA9WI9j2tKL+o2MvKLMnmNxA4D8gblg+iCmUInEX6hHk nasr_identity";
  hosts = [nasr];
in {
  "nextcloud.age".publicKeys = [nasr noor];
  "postgres_nextcloud.age".publicKeys = [nasr noor];
  "authentikenv.age".publicKeys = [nasr noor];
  "aria2c-token.age".publicKeys = [nasr noor];
}
