{...}: let
  fqdn = "photos.igl.ooo";
  secrets = import ../secrets/services.nix;
in {
  services.photoprism = {
    enable = true;

    originalsPath = "/data/photos/originals";
    importPath = "/data/photos/imports";

    passwordFile = /etc/photoprism-admin-password;
  };

  environment.etc."photoprism-admin-password".text = secrets.photoprism.settings.PHOTOPRISM_ADMIN_PASSWORD;

  # force https
  services.nginx = {
    virtualHosts.${fqdn} = {
      enableACME = true;
      forceSSL = true;
    };
  };
}
