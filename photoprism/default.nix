{
  pkgs,
  config,
  ...
}: let
  cfg = config.services.photoprism;
  fqdn = "photos.igl.ooo";
  secrets = import ../secrets/services.nix;
in {
  services.photoprism = {
    enable = true;

    originalsPath = "/var/lib/private/photoprism/originals";

    passwordFile = /etc/photoprism-admin-password;

    settings = {
      inherit
        (secrets.photoprism.settings)
        PHOTOPRISM_ADMIN_USER
        PHOTOPRISM_ADMIN_PASSWORD
        PHOTOPRISM_DEFAULT_LOCALE
        ;

      PHOTOPRISM_DATABASE_DRIVER = "mysql";
      PHOTOPRISM_DATABASE_NAME = "photoprism";
      PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
      PHOTOPRISM_DATABASE_USER = "photoprism";
      PHOTOPRISM_SITE_URL = "https://${fqdn}:${builtins.toString cfg.port}/";
      PHOTOPRISM_SITE_TITLE = "My PhotoPrism";
    };
  };

  environment.etc."photoprism-admin-password".text = secrets.photoprism.settings.PHOTOPRISM_ADMIN_PASSWORD;

  # MySQL
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    ensureDatabases = ["photoprism"];
    ensureUsers = [
      {
        name = "photoprism";
        ensurePermissions = {
          "photoprism.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  # nginx
  services.nginx = {
    virtualHosts.${fqdn} = {
      enableACME = true;
      forceSSL = true;
      locations = {
        "/" = {
          recommendedProxySettings = true;
          proxyPass = "http://127.0.0.1:${builtins.toString cfg.port}/";

          extraConfig = ''
            proxy_buffering off;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
          '';
        };
      };
    };
  };
}
