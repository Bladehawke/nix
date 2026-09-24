{ inputs, pkgs, ... }:

{
  #custom kernals
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;




  nixpkgs.overlays = [
    inputs.nur.overlays.default
    inputs.nix-cachyos-kernel.overlays.pinned
    (_: _: { ##BELOW IS PROPER FOR ANYUTHING
      unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    })
  ];
}
