{
  "languageserver" = {
    "nix" = {
      "command" = "nil";
      "filetypes" = ["nix"];
      "rootPatterns" = ["flake.nix"];
      # Uncomment these to tweak settings.
      "settings" = {
        "nil" = {
          "formatting" = {
            "command" = ["alejandra"];
          };
        };
      };
    };
  };
  "coc" = {
    "preferences" = {
      "formatOnType" = true;
      "formatOnSaveFiletypes" = ["nix"];
    };
  };
}
