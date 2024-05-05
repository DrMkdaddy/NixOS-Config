{
  description = "My nixos flake after the rewrite.";
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    h-m = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    anyrun.url = "github:Kirottu/anyrun";
    hyprland.url = "github:hyprwm/Hyprland";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    xdph.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    neovim-flake.url = "github:notashelf/neovim-flake";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    yazi.url = "github:sxyazi/yazi";
    swwwitch.url = "github:drmkdaddy/swwwitch";
    typed-systems = {
      url = "github:YellowOnion/nix-typed-systems";
      flake = false;
    };
  };
  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://anyrun.cachix.org"
      "https://nix-community.cachix.org"
      "https://yazi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4"
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
  };
  outputs = {
    self,
    nixpkgs-unstable,
    h-m,
    typed-systems,
    ...
  } @ inputs: let
    inherit (import typed-systems) genAttrsMapBy systems' id;
    systems = [
      {
        #Idris is the name of my Laptop
        name = "idris";
        modules = [
          ./idris
          h-m.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.noor = _: {imports = [./shared/home];};
              extraSpecialArgs = {inherit inputs;};
            };
          }
        ];
        system = systems'.x86_64-linux;
      }
      {
        #Nasr is the name of my Desktop hopefully.
        name = "nasr";
        modules = [];
        system = systems'.x86_64-linux;
      }
    ];
    mkConfig = {
      nixpkgs ? nixpkgs-unstable,
      name,
      system,
      modules,
    }: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit nixpkgs;
          inherit inputs;
        };
        modules =
          modules
          ++ [
            ({
              self,
              name,
              ...
            }: {
              networking.hostname = name;
              nix.registry.nixpkgs.flake = nixpkgs;
              nix.registry.self.flake = self;
              nixpkgs.config.allowUnfree = true;
            })
          ]
          ++ [
            ./shared/users.nix
          ];
      };
  in {
    nixosConfigurations = genAttrsMapBy (a: a.name) mkConfig systems id;
  };
}
