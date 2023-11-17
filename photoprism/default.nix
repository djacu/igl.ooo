{config, ...}: let
  cfg = config.services.photoprism;
  fqdn = "photos.igl.ooo";
  secrets = import ../secrets/services.nix;
in {
  services.photoprism = {
    enable = true;

    originalsPath = "/data/photos/originals";
    importPath = "/data/photos/imports";

    passwordFile = /etc/photoprism-admin-password;

    settings = {
      inherit
        (secrets.photoprism.settings)
        PHOTOPRISM_ADMIN_USER
        PHOTOPRISM_ADMIN_PASSWORD
        PHOTOPRISM_DEFAULT_LOCALE
        ;
    };
  };

  environment.etc."photoprism-admin-password".text = secrets.photoprism.settings.PHOTOPRISM_ADMIN_PASSWORD;

  # https://nixos.wiki/wiki/PhotoPrism#Storing_user_data_in_specific_location
  fileSystems."/var/lib/private/photoprism" = {
    device = "/data/photos/photoprism";
    options = ["bind"];
  };

  fileSystems."/var/lib/private/photoprism/originals" = {
    device = "/data/photos/originals";
    options = ["bind"];
  };

  #fileSystems."/var/lib/private/photoprism/upload" = {
  #  device = "/data/photos/upload";
  #  options = ["bind"];
  #};

  # force https
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
