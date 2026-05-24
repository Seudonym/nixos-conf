{ self, inputs, ... }:
{
  flake.nixosConfigurations.zephyrus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.zephyrusConfiguration
    ];
  };
}
