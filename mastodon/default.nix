{...}: let
  fqdn = "mastodon.igl.ooo";
  secrets = import ../secrets/services.nix;
in {
  services.mastodon = {
    enable = true;
    localDomain = fqdn;
    configureNginx = true;

    inherit (secrets.mastodon) smtp;
  };

  # force https
  services.nginx = {
    virtualHosts.${fqdn} = {
      enableACME = true;
      forceSSL = true;
    };
  };
}
