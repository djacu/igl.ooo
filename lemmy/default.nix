{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./base.nix
    ./users.nix
    ./packages.nix
  ];
}
