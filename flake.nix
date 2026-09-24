{
  description = "An example NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";
    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs.nix-gaming.follows = "nix-gaming";
    };

    nix-cachyos-kernel.url =
      "github:xddxdd/nix-cachyos-kernel/release";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hexecute.url = "github:m31-galaxy/Hexecute";

    HyprQuickFrame = {
      url = "github:Ronin-CK/HyprQuickFrame";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
  };


    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations = {
      xf = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./xf/host-xf.nix
          ./xf/overlays.nix

          inputs.nix-citizen.nixosModules.default
          inputs.hjem.nixosModules.default
          inputs.dms-plugin-registry.nixosModules.default

        ];

        specialArgs = {
          inherit inputs;
        };
      };

      yui = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./yui/host-yui.nix
          ./overlays.nix
        ];

        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
