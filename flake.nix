{
  description = "My Nix-OS Config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    system = "x86_64-linux";
    nixConfig = {
      extra-substituters = [
        "https://hyprland.cachix.org"
        "https://nix-gaming.cachix.org"
      ];
      extra-trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4"
      ];
    };
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "noor@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
