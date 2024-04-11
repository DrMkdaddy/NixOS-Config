{
  pkgs,
  inputs,
  ...
}: {
  users.users.noor.packages = with pkgs; [
    vulkan-tools
    jre8
    temurin-jre-bin-17
    geekbench
    inputs.ragenix.packages.x86_64-linux.default
  ];
}
