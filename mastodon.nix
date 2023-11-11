{...}: let
  fqdn = "mastodon.igl.ooo";
in {
  services.mastodon = {
    enable = true;
    localDomain = fqdn;
    configureNginx = true;

    smtp = {
      user = "dan@djacu.dev";
      fromAddress = "mastodon@djacu.dev";
      host = "smtp.zoho.com";
      port = 587;
      passwordFile = ./smtp-password;
      authenticate = true;
    };
  };

  # force https
  services.nginx = {
    virtualHosts.${fqdn} = {
      enableACME = true;
      forceSSL = true;
    };
  };
}
