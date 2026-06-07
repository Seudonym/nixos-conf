{ ... }:
{
  flake.nixosModules.firewall =
    { ... }:
    {
      networking = {
        nftables.enable = true;
        firewall = {
          checkReversePath = false;
          enable = true;
          # allowedTCPPorts = [25565];
          # allowedUDPPorts = [25565];
          allowedTCPPortRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
          allowedUDPPortRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
        };
      };
    };
}
