{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.zephyrus = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs self;
    };

    modules = [
      self.nixosModules.zephyrusConfiguration
    ];
  };
}
