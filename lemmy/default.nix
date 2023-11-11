{...}: let
  fqdn = "lemmy.igl.ooo";
  secrets = import ../secrets/services.nix;
in {
  services.lemmy = {
    enable = true;

    database.createLocally = true;
    database.uri = "postgres:///lemmy?host=/run/postgresql&user=lemmy";

    nginx.enable = true;

    settings.hostname = fqdn;
    settings.setup = {
      inherit (secrets.lemmy.settings.setup) admin_username admin_email;
      site_name = fqdn;
    };

    secretFile = /etc/lemmy-config.hjson;
  };

  environment.etc."lemmy-config.hjson".text = builtins.toJSON secrets.lemmy.lemmy-config-hjson;

  # setup https
  security.acme = {
    acceptTerms = true;
    defaults.email = secrets.admin.email;
    certs = {
      ${fqdn} = {
        webroot = "/var/lib/acme/acme-challenge/";
        reloadServices = [
          "nginx.service"
        ];
      };
    };
  };

  # force https
  services.nginx = {
    virtualHosts.${fqdn} = {
      enableACME = true;
      forceSSL = true;
    };
  };

  # https://github.com/LemmyNet/lemmy/issues/3118
  systemd.services.lemmy.environment = {
    LEMMY_CORS_ORIGIN = "http://" + fqdn;
  };

  # THIS KILLS THE DATABASE
  #systemd.services.postgresql.postStart = ''
  #  $PSQL -tAc 'DROP DATABASE "lemmy"'
  #'';
}
