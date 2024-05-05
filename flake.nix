{
  description = "My nixos flake after the rewrite.";
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

  outputs = {
    nixpkgs,
    home-manager,
    typed-systems,
    ...
  } @ inputs: let
    inherit (import typed-systems) genAttrsMapBy systems' id;
    systems = [
      {
        #Idris is the name of my Laptop
        name = "idris";
        modules = [./idris];
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
      nixpkgs,
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
          nix.registry = {
            nixpkgs.flake = nixpkgs;
            self.flake = self;
          };
          nixpkgs.config.allowUnfree = true;
        })
      ];
  in {
    nixosConfigurations = genAttrsMapBy (a: a.name) mkConfig systems id;
  };
}
