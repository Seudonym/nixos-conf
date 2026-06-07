{ ... }:
{
  flake.nixosModules.syncthing =
    { ... }:
    {
      services.syncthing = {
        enable = true;
        user = "wahid";
        dataDir = "/home/wahid/syncthing/";
        openDefaultPorts = true;
        guiAddress = "0.0.0.0:8384";
        settings = {
          devices = {
            "wahids-m53" = {
              id = "GWZWJDS-SGC4HKD-BH2YH4X-IZ2VCGS-DSBUHBC-NDIYLSW-P75PRKL-LBBWNA6";
            };
          };
          folders = {
            "Documents" = {
              path = "/home/wahid/syncthing/Documents/";
              devices = [ "wahids-m53" ];
            };
          };
        };
      };
      networking.firewall.allowedTCPPorts = [ 8384 ];
    };
}
