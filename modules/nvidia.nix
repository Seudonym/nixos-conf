{...}: {
  flake.nixosModules.nvidia = {...}: {
    hardware = {
      nvidia-container-toolkit.enable = true;
      graphics.enable = true;
      graphics.enable32Bit = true;
      nvidia = {
        open = true;
        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = true;
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };
    };
  };
}
