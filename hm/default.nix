{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.bakerdn = {
    imports = [
      ./base.nix
      ./git.nix
      ./neovim
      ./packages.nix
    ];
  };
}
