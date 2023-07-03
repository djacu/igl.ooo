{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraLuaConfig = ''
      vim.opt.showmatch = true
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.expandtab = true -- converts tabs to white space
      vim.opt.shiftwidth = 4 -- width for autoindents
      vim.opt.autoindent = true -- indent a new line the same amount as the line just typed

      vim.g.mapleader = " "
    '';
    extraConfig = builtins.readFile ./coc.vim;

    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      {
        plugin = nvim-surround;
        type = "lua";
        config = ''
          require("nvim-surround").setup({})
        '';
      }
      {
        plugin = nvim-lastplace;
        type = "lua";
        config = ''
          require'nvim-lastplace'.setup{}
        '';
      }
      {
        plugin = nvim-treesitter;
        type = "lua";
        config = ''
          require'nvim-treesitter.configs'.setup {
            auto_install = false,
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
            };
          }
        '';
      }
    ];
  };
}
