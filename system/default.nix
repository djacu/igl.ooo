{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./base.nix
    ./networking.nix
    ./packages.nix
  ];
}
