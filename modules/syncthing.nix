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
            "wahids-s9" = {
              id = "AH5MC4R-B54ZAMU-ATVZ672-SIZGPWA-PCFG32A-ZVP2SHA-SXMX2H7-6MQDMAY";
            };
          };
          folders = {
            "Documents" = {
              path = "/home/wahid/syncthing/Documents/";
              devices = [
                "wahids-m53"
                "wahids-s9"
              ];
            };
            "books" = {
              path = "/home/wahid/syncthing/books/";
              devices = [
                "wahids-s9"
              ];
            };
          };
        };
      };
      networking.firewall.allowedTCPPorts = [ 8384 ];
    };
}
