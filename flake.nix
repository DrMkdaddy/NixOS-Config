{
  description = "My NixOS flake with support for multiple architectures";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    h-m = {
      url = "github:nix-community/home-manager";
    };
    anyrun = {
      url = "github:anyrun-org/anyrun";
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
    };
    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
    };
    neovim-flake = {
      url = "github:notashelf/neovim-flake";
    };
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
    };
    yazi = {
      url = "github:sxyazi/yazi";
    };
    swwwitch.url = "github:drmkdaddy/swwwitch";
    ragenix = {
      url = "github:yaxitech/ragenix";
    };
    typed-systems = {
      url = "github:YellowOnion/nix-typed-systems";
      flake = false;
    };
    pterodactyl = {
      url = "github:pterodactyl/panel";
    };
    nixified-ai = {
      url = "github:nixified-ai/flake";
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://anyrun.cachix.org"
      "https://nix-community.cachix.org"
      "https://yazi.cachix.org"
      "https://ai.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4"
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
    ];
  };

  outputs = {
    self,
    nixpkgs,
    h-m,
    typed-systems,
    ...
  } @ inputs: let
    inherit (import typed-systems) genAttrsMapBy systems' id;

    nixStuff = _: {
      nix.registry.nixpkgs.flake = nixpkgs;
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "24.05";
    };

    sharedModules = [
      ./shared
      ./global/configuration.nix
      ./specific/nh.nix
      ./specific/steam.nix
      ./specific/resolvd.nix
      ./specific/hyprland.nix
      ./shared/greetd.nix
      ./specific/btrfs.nix
      ./global/users.nix
      ./specific/printing.nix
      ./global/avahi.nix
      nixStuff
      inputs.ragenix.nixosModules.default
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
      extraModules,
      system,
    }: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs nixpkgs;
          host = name;
        };
        modules =
          extraModules
          ++ sharedModules
          ++ [
            (_: {networking.hostName = name;})
            (_: {environment.systemPackages = [inputs.ragenix.packages.${pkgs.system}.default];})
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
