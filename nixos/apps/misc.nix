{pkgs, ...}:
{
  users.users.noor.packages = with pkgs; [
    vulkan-tools
  ];
}
