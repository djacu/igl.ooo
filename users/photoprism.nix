{...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.photoprism = {
    isNormalUser = true;
    home = "/home/photoprism";
    description = "photoprism";
    extraGroups = ["wheel" "mysql"]; # Enable ‘sudo’ for the user.
  };
}
