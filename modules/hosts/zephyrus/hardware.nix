{ self, inputs, ... }:
{
  flake.nixosModules.zephyrusHardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:

    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "sdhci_pci"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
      boot.kernelParams = [
        "nvidia.NVreg_TemporaryFilePath=/var/tmp"
        "nvidia.NVreg_EnableS0ixPowerManagement=1"
      ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/adcbed8a-ebfb-43c5-801b-3f20083059bd";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/FEAC-61DC";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/56293f71-dd4f-46be-bc01-d4d02f5be3c1"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

}
