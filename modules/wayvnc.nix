{ ... }:
{
  flake.nixosModules.wayvnc =
    { ... }:
    {
      programs.wayvnc.enable = true;
      networking.firewall.allowedTCPPorts = [ 5900 ];
    };
}
