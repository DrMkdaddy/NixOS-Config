{pkgs, ...}:
{
  users.users.noor.packages = with pkgs; [
    vulkan-tools
    jre8
    temurin-jre-bin-17
  ];
}
