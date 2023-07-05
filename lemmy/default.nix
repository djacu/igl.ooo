{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./base.nix
    ./users.nix
    ./lemmy.nix
    ./networking.nix
  ];
}
