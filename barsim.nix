let
  barsim = import ./default.nix {};
in {
  barsim = {
    deployment.targetEnv = "container";
    networking.firewall.allowedTCPPorts = [ 80 ];

    services.nginx = {
      enable = true;
      virtualHosts = {
        "barsim.com" = {
          root = "${barsim}/";
        };
      };
    };
  };
}
