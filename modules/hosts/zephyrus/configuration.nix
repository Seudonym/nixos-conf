{ self, ... }:
{
  flake.nixosModules.zephyrusConfiguration =
    { inputs, ... }:
    {
      imports = [
        self.nixosModules.zephyrusHardware
        self.nixosModules.desktop
        self.nixosModules.firewall
        self.nixosModules.dns
        self.nixosModules.locale
        self.nixosModules.nvidia
        self.nixosModules.nix

        self.nixosModules.spicetify
        self.nixosModules.dev

        self.nixosModules.tailscale
        self.nixosModules.wayvnc
        self.nixosModules.syncthing

        self.nixosModules.userWahid

        self.nixosModules.sops
        self.nixosModules.stt
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking = {
        networkmanager.enable = true;
        hostName = "zephyrus";
      };

      services = {
        xserver = {
          videoDrivers = [
            "amdgpu"
            "nvidia"
          ];
        };
        supergfxd.enable = true;
        asusd.enable = true;
      };

      hardware.bluetooth.enable = true;
      hardware.nvidia.prime = {
        amdgpuBusId = "PCI:6:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };

      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.permittedInsecurePackages = [
        "openssl-1.1.1w"
      ];

      system.stateVersion = "25.11";
    };
}
