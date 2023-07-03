{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      coc-cmake
      coc-css
      coc-docker
      coc-explorer
      coc-highlight
      coc-html
      coc-json
      coc-lists
      coc-pyright
      coc-toml
      coc-tsserver
      coc-yaml
    ];
    withNodeJs = true;
    extraPackages = [
      pkgs.nil
      pkgs.alejandra
    ];
    coc = {
      enable = true;
      settings = import ./coc-settings.nix;
    };
  };
}
