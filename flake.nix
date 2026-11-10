{
  description = "NixOS configuration for chimay";

  # Pin the NixOS channel used to build this system.
  # Bump this to migrate to a newer release (e.g. nixos-26.11).
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.11pre";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.chimay = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
    };
}
