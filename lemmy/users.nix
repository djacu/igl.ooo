{...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bakerdn = {
    isNormalUser = true;
    home = "/home/bakerdn";
    description = "it's a me";
    extraGroups = ["wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICHlCIa+u3swjr11yvoNrp8qqt1YPt/Fa7DIbX7Xthr5 bakerdn@bahamut"
    ];
  };
}
