{
  description = "My NixOS flake with support for multiple architectures";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    h-m = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    anyrun.url = "github:anyrun-org/anyrun";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
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

    sharedModules = [
      ./shared
      ./global/configuration.nix
      ./specific/nh.nix
      ./specific/steam.nix
      ./specific/resolvd.nix
      ./specific/hyprland.nix
      ./shared/greetd.nix
    ];

    hostModules = {
      idris = [./idris];
      nasr = [./nasr];
    };
    systems = [
      {
        name = "idris";
        extraModules = hostModules.idris;
        arch = systems'.x86_64-linux;
      }
      {
        name = "nasr";
        extraModules = hostModules.nasr;
        arch = systems'.x86_64-linux;
      }
      # Add more systems with different architectures here
    ];

    createSystem = {
      name,
      extraModules ? [],
      system,
    }: let
      pkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
      nixpkgs-unstable.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs nixpkgs-unstable;
          host = name;
        };
        modules =
          extraModules
          ++ sharedModules
          ++ [
            (_: {
              networking.hostName = name;
              nix.registry.nixpkgs.flake = nixpkgs-unstable;
              nixpkgs.config.allowUnfree = true;
              system.stateVersion = "24.05";
            })
            ./global/users.nix
            h-m.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.noor = _: {imports = [./shared/home ./${name}/home];};
                extraSpecialArgs = {
                  inherit inputs;
                  host = name;
                };
                backupFileExtension = "backup";
              };
            }
          ];
      };
  in {
    nixosConfigurations =
      genAttrsMapBy (a: a.name) (a:
        createSystem {
          inherit (a) name extraModules;
          system = a.arch;
        })
      systems
      id;
  };
}
